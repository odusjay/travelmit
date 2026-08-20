import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/universities.dart';
import '../models/journey.dart';
import '../services/purchase_service.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'paywall_screen.dart';

enum _Filter { all, englishBachelor, englishMaster, public, applied }

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({super.key});

  @override
  State<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  _Filter _filter = _Filter.all;

  List<University> get _filtered {
    final list = switch (_filter) {
      _Filter.all => universities.toList(),
      _Filter.englishBachelor => withEnglishBachelors(),
      _Filter.englishMaster => withEnglishMasters(),
      _Filter.public => universitiesOfType(InstitutionType.publicUniversity),
      _Filter.applied => universitiesOfType(InstitutionType.appliedSciences),
    };
    list.sort((a, b) =>
        (a.tuitionPerSemesterEur ?? 9999).compareTo(b.tuitionPerSemesterEur ?? 9999));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final unlocked = context.watch<PurchaseService>().isUnlocked;

    if (!unlocked) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Schools'),
          actions: const [ThemeToggle(), SizedBox(width: 6)],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 38, color: p.inkMuted),
                const SizedBox(height: 16),
                Text(
                  'Every Austrian university and applied sciences school that '
                  'charges under \u20AC2,000 a year, with the English '
                  'programmes each one runs and the deposits some of them ask '
                  'for at application.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14, height: 1.55, color: p.inkMuted),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PaywallScreen()),
                  ),
                  child: const Text('Open the full guide'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schools'),
        actions: const [ThemeToggle(), SizedBox(width: 6)],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
        children: [
          Text(
            'Only places charging \u20AC2,000 a year or less. Sorted cheapest '
            'first.',
            style: TextStyle(fontSize: 13, height: 1.5, color: p.inkMuted),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 42,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _chip('All', _Filter.all),
                _chip('English Bachelor', _Filter.englishBachelor),
                _chip('English Master', _Filter.englishMaster),
                _chip('Public', _Filter.public),
                _chip('Applied sciences', _Filter.applied),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ..._filtered.map((u) => _UniCard(uni: u)),
          const SizedBox(height: 18),
          const _AvoidList(),
        ],
      ),
    );
  }

  Widget _chip(String label, _Filter value) {
    final p = context.palette;
    final selected = _filter == value;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        showCheckmark: false,
        onSelected: (_) => setState(() => _filter = value),
        backgroundColor: p.card,
        selectedColor: p.accentSoft,
        side: BorderSide(color: selected ? p.accent : p.line),
        labelStyle: TextStyle(
          fontSize: 12.5,
          color: selected ? p.accent : p.ink,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }
}

class _UniCard extends StatelessWidget {
  final University uni;
  const _UniCard({required this.uni});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final yearly = uni.tuitionPerYearEur;

    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                uni.name,
                style: const TextStyle(
                    fontSize: 15.5, fontWeight: FontWeight.w700, height: 1.3),
              ),
              const SizedBox(height: 4),
              Text(
                '${uni.city}  \u00B7  ${uni.typeLabel}',
                style: TextStyle(fontSize: 12.5, color: p.inkMuted),
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  Icon(Icons.payments_outlined, size: 15, color: p.inkMuted),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      yearly == null
                          ? 'Fee not confirmed, check with them directly'
                          : '\u20AC${yearly.round()} a year',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: yearly == null ? p.inkMuted : p.ok,
                      ),
                    ),
                  ),
                  if (!uni.feeVerified)
                    Tooltip(
                      message: 'Not yet confirmed against their own page',
                      child: Icon(Icons.help_outline, size: 15, color: p.warn),
                    ),
                ],
              ),
              if (uni.applicationFeeEur != null) ...[
                const SizedBox(height: 11),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: p.warnBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.account_balance_wallet_outlined,
                          size: 15, color: p.warn),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deposit \u20AC${uni.applicationFeeEur!.round()}',
                              style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: p.warn),
                            ),
                            if (uni.applicationFeeNote != null) ...[
                              const SizedBox(height: 3),
                              Text(
                                uni.applicationFeeNote!,
                                style: TextStyle(
                                    fontSize: 12, height: 1.4, color: p.warn),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (uni.hasEnglishBachelor) ...[
                const SizedBox(height: 14),
                _Programmes(
                    label: 'ENGLISH BACHELOR', items: uni.englishBachelors),
              ],
              if (uni.hasEnglishMaster) ...[
                const SizedBox(height: 12),
                _Programmes(
                    label: 'ENGLISH MASTER', items: uni.englishMasters),
              ],
              if (uni.note != null) ...[
                const SizedBox(height: 12),
                Text(
                  uni.note!,
                  style: TextStyle(
                      fontSize: 12.5, height: 1.5, color: p.inkMuted),
                ),
              ],
              if (uni.admissionsUrl != null || uni.website != null) ...[
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => openUrl(uni.admissionsUrl ?? uni.website!),
                    icon: const Icon(Icons.open_in_new, size: 16),
                    label: Text(
                      uni.admissionsUrl != null
                          ? 'Apply on their website'
                          : 'Visit their website',
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: p.accent,
                      side: BorderSide(color: p.accent.withValues(alpha: 0.4)),
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9)),
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

class _Programmes extends StatelessWidget {
  final String label;
  final List<String> items;

  const _Programmes({required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: p.inkMuted,
          ),
        ),
        const SizedBox(height: 7),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: items.map((i) => Pill(text: i)).toList(),
        ),
      ],
    );
  }
}

/// Deliberately shown rather than hidden. Knowing what to avoid is as useful
/// as knowing where to apply.
class _AvoidList extends StatelessWidget {
  const _AvoidList();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading('Priced out of this guide'),
        const SizedBox(height: 8),
        Text(
          'These are real institutions and they are not bad places to study. '
          'They are simply far beyond what this guide is aimed at. Listed so '
          'you know the price before you apply rather than after you are '
          'accepted.',
          style: TextStyle(fontSize: 13, height: 1.55, color: p.inkMuted),
        ),
        const SizedBox(height: 14),
        ...expensiveInstitutions.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: p.warnBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            e.name,
                            style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: p.warn),
                          ),
                        ),
                        Text(
                          e.yearlyCost,
                          style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: p.warn),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      e.warning,
                      style: TextStyle(
                          fontSize: 12.5, height: 1.5, color: p.warn),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
