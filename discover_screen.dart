import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/discover_content.dart';
import '../data/support_content.dart';
import '../models/journey.dart';
import '../services/review_service.dart';
import '../services/settings_service.dart';
import '../theme.dart';
import '../widgets/common.dart';

class DiscoverScreen extends StatelessWidget {
  final VoidCallback onStart;
  const DiscoverScreen({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _Hero(onStart: onStart),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (testimonials.isNotEmpty) ...[
                  const _Reviews(),
                  const SizedBox(height: 22),
                ],
                ...discoverSections.map((s) => _SectionCard(section: s)),
                const SizedBox(height: 10),
                const _SupportTeaser(),
                const SizedBox(height: 22),
                const _Reality(),
                const SizedBox(height: 22),
                FilledButton(onPressed: onStart, child: const Text(ctaLabel)),
                const SizedBox(height: 16),
                Text(
                  'Written from experience, not from a textbook. It is not '
                  'legal or immigration advice, and rules do change, so check '
                  'anything important with the embassy before you act on it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11.5, height: 1.55, color: p.inkMuted),
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  final VoidCallback onStart;
  const _Hero({required this.onStart});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [p.heroFrom, p.heroTo],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  appName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
                const Spacer(),
                const _HeroThemeToggle(),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              heroTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 31,
                fontWeight: FontWeight.w800,
                height: 1.18,
                letterSpacing: -0.6,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              heroSubtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.72),
                fontSize: 14.5,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 26),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: heroStats
                  .map((s) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.value,
                                style: TextStyle(
                                  color: p.accent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                s.label,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.55),
                                  fontSize: 11,
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Toggle styled for the dark hero, where the usual muted colour disappears.
class _HeroThemeToggle extends StatelessWidget {
  const _HeroThemeToggle();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return IconButton(
      tooltip: isDark ? 'Switch to light' : 'Switch to dark',
      icon: Icon(
        isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        size: 20,
        color: Colors.white.withValues(alpha: 0.75),
      ),
      onPressed: () => context.read<SettingsService>().toggle(brightness),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final DiscoverSection section;
  const _SectionCard({required this.section});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(section.icon, style: const TextStyle(fontSize: 21)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      section.title,
                      style: const TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w700,
                        height: 1.35,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Prose(section.body),
              if (section.facts.isNotEmpty) ...[
                const SizedBox(height: 2),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: section.facts.map((f) => Pill(text: f)).toList(),
                ),
              ],
              if (section.insiderTip != null) ...[
                const SizedBox(height: 14),
                Callout(
                  text: section.insiderTip!,
                  icon: Icons.lightbulb_outline,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SupportTeaser extends StatelessWidget {
  const _SupportTeaser();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: p.accentSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: p.accent.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_shipping_outlined, size: 19, color: p.accent),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  supportHeadline,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: p.accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            supportTeaser,
            style: TextStyle(fontSize: 14, height: 1.6, color: p.ink),
          ),
        ],
      ),
    );
  }
}

class _Reality extends StatelessWidget {
  const _Reality();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: p.heroFrom,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            realityTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1.3,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 14),
          Prose(realityBody, color: Colors.white.withValues(alpha: 0.75)),
        ],
      ),
    );
  }
}

class _Reviews extends StatelessWidget {
  const _Reviews();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final avg = testimonials.isEmpty
        ? 0.0
        : testimonials.map((t) => t.rating).reduce((a, b) => a + b) /
            testimonials.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ...List.generate(
              5,
              (i) => Icon(
                i < avg.round() ? Icons.star_rounded : Icons.star_outline_rounded,
                size: 18,
                color: p.warn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${avg.toStringAsFixed(1)} from ${testimonials.length} '
              '${testimonials.length == 1 ? "person" : "people"}',
              style: TextStyle(fontSize: 13, color: p.inkMuted),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: testimonials.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, i) => _ReviewCard(t: testimonials[i]),
          ),
        ),
        if (ReviewService.isConfigured) ...[
          const SizedBox(height: 10),
          TextButton.icon(
            onPressed: ReviewService.openStoreListing,
            icon: const Icon(Icons.rate_review_outlined, size: 16),
            label: const Text('Leave a review'),
          ),
        ],
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Testimonial t;
  const _ReviewCard({required this.t});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return SizedBox(
      width: 260,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(
                  t.rating,
                  (_) => Icon(Icons.star_rounded, size: 14, color: p.warn),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Text(
                  t.quote,
                  style: const TextStyle(fontSize: 13.5, height: 1.5),
                  overflow: TextOverflow.fade,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                t.name,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600),
              ),
              Text(
                t.detail,
                style: TextStyle(fontSize: 11.5, color: p.inkMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
