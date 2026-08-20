import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/support_content.dart';
import '../services/purchase_service.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'paywall_screen.dart';

/// Explains the Abuja document service. Contact details appear only after
/// purchase.
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final unlocked = context.watch<PurchaseService>().isUnlocked;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Abuja support'),
        actions: const [ThemeToggle(), SizedBox(width: 6)],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
        children: [
          Text(
            supportHeadline,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 14),
          Prose(supportIntro, size: 15),
          const SizedBox(height: 18),
          const SectionHeading('How it works'),
          const SizedBox(height: 14),
          ...supportSteps.asMap().entries.map(
                (e) => _Step(index: e.key + 1, title: e.value.title, detail: e.value.detail),
              ),
          const SizedBox(height: 10),
          Callout(
            text: supportNote,
            icon: Icons.info_outline,
            warning: false,
          ),
          const SizedBox(height: 22),
          if (unlocked)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supportTeamName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tell them which stage you are on and how many documents '
                      'you have. They will come back with a price.',
                      style: TextStyle(
                          fontSize: 13.5, height: 1.5, color: p.inkMuted),
                    ),
                    const SizedBox(height: 14),
                    FilledButton.icon(
                      onPressed: () => openEmail(
                        supportEmail,
                        subject: 'Document assistance request',
                      ),
                      icon: const Icon(Icons.mail_outline, size: 19),
                      label: const Text('Email the team'),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SelectableText(
                        supportEmail,
                        style: TextStyle(fontSize: 13, color: p.inkMuted),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Icon(Icons.lock_outline, size: 30, color: p.inkMuted),
                    const SizedBox(height: 12),
                    Text(
                      'Contact details for the Abuja team come with the full '
                      'guide.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14, height: 1.5, color: p.inkMuted),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const PaywallScreen()),
                      ),
                      child: const Text('Open the full guide'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final int index;
  final String title;
  final String detail;

  const _Step({
    required this.index,
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: p.accentSoft,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$index',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w700, color: p.accent),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 14.5, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Text(
                  detail,
                  style: TextStyle(
                      fontSize: 13.5, height: 1.55, color: p.inkMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
