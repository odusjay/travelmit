import 'package:flutter/material.dart';

import '../models/journey.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// A quick-reference checklist: what you need, by education level, in one
/// place. Pulls the educational documents straight from EducationLevel so
/// this never drifts out of sync with the calculator or the journey steps.
class RequirementsScreen extends StatelessWidget {
  const RequirementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Scaffold(
      appBar: AppBar(
        title: const Text('What you need'),
        actions: const [ThemeToggle(), SizedBox(width: 6)],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
        children: [
          Text(
            'Everyone needs proof of English and two personal documents on '
            'top of their educational papers. Pick your level below.',
            style: TextStyle(fontSize: 13.5, height: 1.55, color: p.inkMuted),
          ),
          const SizedBox(height: 18),
          ...EducationLevel.values.map((l) => _LevelCard(level: l)),
          const SizedBox(height: 6),
          Callout(
            text: 'Married? Add your marriage certificate to whichever list '
                'above applies to you.',
            icon: Icons.favorite_border,
            warning: false,
          ),
        ],
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final EducationLevel level;
  const _LevelCard({required this.level});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    // Educational papers come straight from the model. English proof and
    // the two personal documents apply at every level, so they're added
    // here rather than duplicated in the model for each one.
    final items = [
      ...level.educationalDocuments,
      'IELTS 6.0 or Duolingo 110',
      'Attestation of birth certificate',
      'Declaration of age',
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      level.label,
                      style: const TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  Pill(text: '${items.length} documents'),
                ],
              ),
              const SizedBox(height: 14),
              ...items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle_outline,
                            size: 16, color: p.accent),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                                fontSize: 13.5, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
