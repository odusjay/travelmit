import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/journey.dart';
import '../services/progress_service.dart';
import '../services/purchase_service.dart';
import '../services/exchange_rate_service.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'support_screen.dart';
import 'paywall_screen.dart';

class StepDetailScreen extends StatelessWidget {
  final JourneyStep step;
  const StepDetailScreen({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final done = context.select<ProgressService, bool>(
        (s) => s.isStepComplete(step.id));

    return Scaffold(
      appBar: AppBar(
        title: Text('Step ${step.order}'),
        actions: const [ThemeToggle(), SizedBox(width: 6)],
      ),
      body: ListView(
        key: PageStorageKey('step-detail-${step.id}'),
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 110),
        children: [
          if (step.timing == StepTiming.parallel && step.runsDuring != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Callout(
                text: 'This runs ${step.runsDuring}. Do not wait for the '
                    'previous step to finish before starting it.',
                icon: Icons.sync,
              ),
            ),
          if (step.timing == StepTiming.startsClock)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Callout(
                text: 'Start here. Everything in this block happens while you '
                    'wait for what this step sets in motion.',
                icon: Icons.play_arrow_outlined,
                warning: false,
              ),
            ),
          Text(
            step.title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            step.summary,
            style: TextStyle(fontSize: 15, height: 1.5, color: p.inkMuted),
          ),
          if (step.timeline != null) ...[
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(Icons.schedule, size: 15, color: p.inkMuted),
                const SizedBox(width: 7),
                Text(
                  step.timeline!,
                  style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: p.inkMuted),
                ),
              ],
            ),
          ],
          const SizedBox(height: 20),
          Prose(step.detail, size: 15),
          if (step.criticalNote != null) ...[
            const SizedBox(height: 4),
            Callout(text: step.criticalNote!, icon: Icons.priority_high),
          ],
          if (step.needsAbuja) ...[
            const SizedBox(height: 16),
            const _AbujaCard(),
          ],
          if (step.documents.isNotEmpty) ...[
            const SizedBox(height: 28),
            const SectionHeading('What you need'),
            const SizedBox(height: 12),
            ...step.documents.map((d) => _DocumentTile(doc: d)),
          ],
          if (step.costs.isNotEmpty) ...[
            const SizedBox(height: 28),
            const SectionHeading('What you pay here'),
            const SizedBox(height: 6),
            Text(
              'Only this stage. Other costs land months apart.',
              style: TextStyle(fontSize: 12.5, color: p.inkMuted),
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  for (var i = 0; i < step.costs.length; i++) ...[
                    if (i > 0) Divider(height: 1, color: p.line),
                    _CostRow(cost: step.costs[i]),
                  ],
                ],
              ),
            ),
          ],
          if (step.links.isNotEmpty) ...[
            const SizedBox(height: 28),
            const SectionHeading('Links'),
            const SizedBox(height: 12),
            ...step.links.map((l) => _LinkTile(link: l)),
          ],
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 26),
        decoration: BoxDecoration(
          color: p.card,
          border: Border(top: BorderSide(color: p.line)),
        ),
        child: FilledButton.icon(
          onPressed: () =>
              context.read<ProgressService>().toggleStep(step.id),
          icon: Icon(done ? Icons.undo : Icons.check, size: 19),
          label: Text(done ? 'Not done after all' : 'Mark this done'),
          style: done
              ? FilledButton.styleFrom(backgroundColor: p.inkMuted)
              : null,
        ),
      ),
    );
  }
}

class _AbujaCard extends StatelessWidget {
  const _AbujaCard();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Container(
      decoration: BoxDecoration(
        color: p.accentSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: p.accent.withValues(alpha: 0.25)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const SupportScreen()),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Icon(Icons.local_shipping_outlined, size: 20, color: p.accent),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This one is in Abuja',
                        style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: p.accent),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'You can send your documents instead of travelling. '
                        'See how it works.',
                        style: TextStyle(
                            fontSize: 13, height: 1.45, color: p.ink),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: p.accent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DocumentTile extends StatelessWidget {
  final RequiredDocument doc;
  const _DocumentTile({required this.doc});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final progress = context.watch<ProgressService>();
    final checked = progress.isDocumentComplete(doc.id);

    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 22,
                    height: 22,
                    child: Checkbox(
                      value: checked,
                      activeColor: p.ok,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onChanged: (_) => context
                          .read<ProgressService>()
                          .toggleDocument(doc.id),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Text(
                      doc.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.5,
                        height: 1.35,
                        decoration: checked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: checked ? p.inkMuted : p.ink,
                      ),
                    ),
                  ),
                ],
              ),
              if (doc.explanation != null) ...[
                const SizedBox(height: 9),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Text(
                    doc.explanation!,
                    style: TextStyle(
                        fontSize: 13, height: 1.5, color: p.inkMuted),
                  ),
                ),
              ],
              if (doc.warning != null) ...[
                const SizedBox(height: 11),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Callout(
                    text: doc.warning!,
                    icon: Icons.warning_amber_rounded,
                  ),
                ),
              ],
              if (doc.link != null) ...[
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 29),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () => openUrl(doc.link!),
                      icon: const Icon(Icons.open_in_new, size: 15),
                      label: Text(doc.linkLabel ?? 'Open'),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CostRow extends StatelessWidget {
  final CostItem cost;
  const _CostRow({required this.cost});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final rates = context.watch<ExchangeRateService>();
    final nairaText = cost.currency == Currency.eur
        ? rates.nairaEquivalent(cost.amount)
        : null;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cost.label, style: const TextStyle(fontSize: 14)),
                if (cost.note != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    cost.note!,
                    style: TextStyle(fontSize: 11.5, color: p.warn),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                cost.formatted,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 14.5),
              ),
              if (nairaText != null) ...[
                const SizedBox(height: 2),
                Text(
                  '\u2248 $nairaText',
                  style: TextStyle(fontSize: 11, color: p.inkMuted),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  final StepLink link;
  const _LinkTile({required this.link});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final isUnlocked = context.watch<PurchaseService>().isUnlocked;
    final locked = link.premiumOnly && !isUnlocked;

    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Card(
        child: ListTile(
          leading: Icon(
            locked ? Icons.lock_outline : Icons.link,
            color: locked ? p.inkMuted : p.accent,
            size: 20,
          ),
          title: Text(
            locked ? 'Direct link \u2013 included with the full guide' : link.label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.5,
              color: locked ? p.inkMuted : null,
            ),
          ),
          trailing: Icon(
            locked ? Icons.lock_outline : Icons.open_in_new,
            size: 17,
            color: p.inkMuted,
          ),
          onTap: locked
              ? () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PaywallScreen()),
                  )
              : () => openUrl(link.url),
        ),
      ),
    );
  }
}
