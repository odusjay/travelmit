import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/journey_content.dart';
import '../models/journey.dart';
import '../services/progress_service.dart';
import '../services/purchase_service.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'step_detail_screen.dart';
import 'paywall_screen.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final allIds = journeySteps.map((s) => s.id).toList();
    final progressValue = context.select<ProgressService, double>(
        (s) => s.progressFor(allIds));
    final purchases = context.watch<PurchaseService>();
    final p = context.palette;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your journey'),
        actions: const [ThemeToggle(), SizedBox(width: 6)],
      ),
      body: ListView(
        key: const PageStorageKey('journey-list'),
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
        children: [
          _Progress(value: progressValue),
          const SizedBox(height: 18),
          if (!purchases.isUnlocked) ...[
            const _UnlockCard(),
            const SizedBox(height: 18),
          ],
          Text(
            'IN NIGERIA',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: p.inkMuted,
            ),
          ),
          const SizedBox(height: 12),
          ...blocksForPhase(Phase.homeCountry).map((b) => _Block(block: b)),
          const SizedBox(height: 14),
          Text(
            'IN AUSTRIA',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: p.inkMuted,
            ),
          ),
          const SizedBox(height: 12),
          ...blocksForPhase(Phase.postArrival).map((b) => _Block(block: b)),
        ],
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  final double value;
  const _Progress({required this.value});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final done = (value * journeySteps.length).round();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$done of ${journeySteps.length} steps done',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  '${(value * 100).round()}%',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: p.accent),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 7,
                backgroundColor: p.line,
                valueColor: AlwaysStoppedAnimation<Color>(p.accent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UnlockCard extends StatelessWidget {
  const _UnlockCard();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const PaywallScreen()),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.lock_open_outlined, size: 20, color: p.accent),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Open the full guide',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14.5)),
                    SizedBox(height: 3),
                    Text(
                      'One payment. Every step, document and cost.',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: p.inkMuted),
            ],
          ),
        ),
      ),
    );
  }
}

/// A named span of the journey with its steps nested inside.
class _Block extends StatelessWidget {
  final JourneyBlock block;
  const _Block({required this.block});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final steps = stepsForBlock(block.id);
    final progress = context.watch<ProgressService>();
    final doneCount =
        steps.where((s) => progress.isStepComplete(s.id)).length;

    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: p.accentSoft,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14)),
              border: Border.all(color: p.accent.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        block.title,
                        style: TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          color: p.accent,
                        ),
                      ),
                    ),
                    Text(
                      '$doneCount/${steps.length}',
                      style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: p.accent),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 13, color: p.accent),
                    const SizedBox(width: 5),
                    Text(
                      block.duration,
                      style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: p.accent),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                Text(
                  block.description,
                  style: TextStyle(
                      fontSize: 13, height: 1.5, color: p.ink),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ...steps.map((s) => _StepTile(step: s)),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  final JourneyStep step;
  const _StepTile({required this.step});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final progress = context.watch<ProgressService>();
    final purchases = context.watch<PurchaseService>();

    final done = progress.isStepComplete(step.id);
    final locked = !purchases.isUnlocked && !step.isFreePreview;
    final parallel = step.timing == StepTiming.parallel;

    return Padding(
      padding: EdgeInsets.only(bottom: 8, left: parallel ? 16 : 0),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) =>
                locked ? const PaywallScreen() : StepDetailScreen(step: step),
          )),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Marker(step: step, done: done, locked: locked),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (parallel && step.runsDuring != null) ...[
                        Text(
                          'AT THE SAME TIME',
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.9,
                            color: p.warn,
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                      if (step.timing == StepTiming.startsClock) ...[
                        Text(
                          'DO THIS FIRST',
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.9,
                            color: p.accent,
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                      Text(
                        step.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.5,
                          height: 1.3,
                          color: locked ? p.inkMuted : p.ink,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        step.summary,
                        style: TextStyle(
                            fontSize: 12.5, height: 1.4, color: p.inkMuted),
                      ),
                      if (parallel && step.runsDuring != null) ...[
                        const SizedBox(height: 7),
                        Text(
                          'Runs ${step.runsDuring}',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontStyle: FontStyle.italic,
                            color: p.warn,
                          ),
                        ),
                      ],
                      if (step.timeline != null) ...[
                        const SizedBox(height: 8),
                        Pill(text: step.timeline!),
                      ],
                      if (step.needsAbuja) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.place_outlined,
                                size: 12, color: p.inkMuted),
                            const SizedBox(width: 4),
                            Text(
                              'Abuja',
                              style: TextStyle(
                                  fontSize: 11.5, color: p.inkMuted),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Icon(
                    locked ? Icons.lock_outline : Icons.chevron_right,
                    size: 19,
                    color: p.inkMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Marker extends StatelessWidget {
  final JourneyStep step;
  final bool done;
  final bool locked;

  const _Marker(
      {required this.step, required this.done, required this.locked});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    final bg = done
        ? p.okBg
        : locked
            ? p.bg
            : p.accentSoft;
    final fg = done
        ? p.ok
        : locked
            ? p.inkMuted
            : p.accent;

    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: done
          ? Icon(Icons.check, size: 18, color: fg)
          : Text(
              '${step.order}',
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 13, color: fg),
            ),
    );
  }
}
