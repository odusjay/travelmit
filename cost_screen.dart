import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/journey.dart';
import '../services/purchase_service.dart';
import '../services/exchange_rate_service.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'paywall_screen.dart';
import 'requirements_screen.dart';

/// Costs are shown stage by stage rather than as one total. The stages are
/// months apart, so a single figure would tell nobody what they actually need
/// on any given day.
class CostScreen extends StatefulWidget {
  const CostScreen({super.key});

  @override
  State<CostScreen> createState() => _CostScreenState();
}

class _CostScreenState extends State<CostScreen> {
  EducationLevel _level = EducationLevel.oLevel;
  bool _hasPartner = false;
  EducationLevel _partnerLevel = EducationLevel.oLevel;
  int _children = 0;
  bool _marriageCert = false;
  bool _bachelorhoodCert = false;

  // Fixed amounts
  static const _legalisationPerDoc = 80.0;
  static const _vfsPerDoc = 15.0;
  static const _lawyerSingle = 400.0;
  static const _lawyerFamily = 500.0;
  static const _residencePermit = 218.0;
  static const _pccLegalisation = 80.0;
  static const _dVisa = 150.0;
  static const _travelInsuranceNgn = 30000.0;
  static const _tuitionPerYear = 1453.44;
  static const _ohPerSemester = 26.20;

  /// Documents needing authentication and legalisation.
  int get _documentCount {
    // Applicant: educational papers, attestation of birth, declaration of age.
    var count = _level.documentCount + 2;

    if (_hasPartner) {
      count += _partnerLevel.documentCount + 2;
      count += 1; // marriage certificate for a couple
    }

    // Each child: birth certificate and declaration of age.
    count += _children * 2;

    if (_marriageCert && !_hasPartner) count += 1;
    if (_bachelorhoodCert) count += 1;

    return count;
  }

  double get _lawyerFee =>
      (_hasPartner || _children > 0) ? _lawyerFamily : _lawyerSingle;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final unlocked = context.watch<PurchaseService>().isUnlocked;

    if (!unlocked) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Costs'),
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
                  'Work out what each stage costs for your situation, based on '
                  'your education level and whether family are coming with '
                  'you.',
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

    final docs = _documentCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Costs'),
        actions: const [ThemeToggle(), SizedBox(width: 6)],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
        children: [
          Text(
            'Your document count decides most of what you pay, so start there.',
            style: TextStyle(fontSize: 13.5, height: 1.5, color: p.inkMuted),
          ),
          const SizedBox(height: 14),
          Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const RequirementsScreen()),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.checklist_outlined, size: 20, color: p.accent),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('See the full document checklist',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 14.5)),
                          SizedBox(height: 3),
                          Text(
                            'Everything needed at each education level, in one place.',
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
          ),
          const SizedBox(height: 20),

          const _Label('Your education level'),
          const SizedBox(height: 8),
          ...EducationLevel.values.map((l) => _Choice(
                selected: _level == l,
                title: l.label,
                subtitle: '${l.documentCount} educational documents',
                onTap: () => setState(() => _level = l),
              )),

          const SizedBox(height: 22),
          const _Label('Who is travelling'),
          const SizedBox(height: 8),
          _Choice(
            selected: !_hasPartner,
            title: 'Just me',
            subtitle: 'Lawyer fee of \u20AC400 at VFS',
            onTap: () => setState(() => _hasPartner = false),
          ),
          _Choice(
            selected: _hasPartner,
            title: 'With my partner',
            subtitle: 'Lawyer fee rises to \u20AC500, plus their documents',
            onTap: () => setState(() => _hasPartner = true),
          ),

          if (_hasPartner) ...[
            const SizedBox(height: 16),
            const _Label('Your partner\u2019s education level'),
            const SizedBox(height: 8),
            ...EducationLevel.values.map((l) => _Choice(
                  selected: _partnerLevel == l,
                  title: l.label,
                  subtitle: '${l.documentCount} educational documents',
                  onTap: () => setState(() => _partnerLevel = l),
                )),
          ],

          const SizedBox(height: 22),
          const _Label('Children coming with you'),
          const SizedBox(height: 4),
          Text(
            'Two documents each: birth certificate and declaration of age.',
            style: TextStyle(fontSize: 12.5, color: p.inkMuted),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _Stepper(
                value: _children,
                onChanged: (v) => setState(() => _children = v),
              ),
            ],
          ),

          const SizedBox(height: 22),
          const _Label('Worth adding while you are here'),
          const SizedBox(height: 8),
          if (!_hasPartner)
            _Check(
              value: _marriageCert,
              title: 'Marriage certificate',
              subtitle:
                  'If you are married but travelling alone first. Legalise it '
                  'now rather than from Austria later.',
              onChanged: (v) => setState(() => _marriageCert = v),
            ),
          _Check(
            value: _bachelorhoodCert,
            title: 'Bachelorhood certificate',
            subtitle:
                'Not required, but needed if you ever want to marry in '
                'Austria.',
            onChanged: (v) => setState(() => _bachelorhoodCert = v),
          ),

          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: p.accentSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.description_outlined, size: 20, color: p.accent),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '$docs documents to authenticate and legalise',
                    style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: p.accent),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 26),
          Text(
            'STAGE BY STAGE',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: p.inkMuted,
            ),
          ),
          const SizedBox(height: 12),
          const _RateBanner(),
          const SizedBox(height: 14),

          _Stage(
            title: 'At VFS, on submission day',
            when: 'Around month 6',
            rows: [
              ('Lawyer fee, set by the embassy', _lawyerFee, null),
              ('VFS processing, $docs documents', docs * _vfsPerDoc, null),
            ],
            note: 'Both are paid over the counter on the day. Bring the money '
                'with you. Processing runs \u20AC10 to \u20AC15 a document, so '
                'this is the upper estimate.',
          ),

          _Stage(
            title: 'Embassy legalisation',
            when: 'After verification, 2 to 4 months later',
            rows: [
              ('\u20AC80 per document, $docs documents',
                  docs * _legalisationPerDoc, null),
            ],
            note: 'This is why the document count matters so much.',
          ),

          _Stage(
            title: 'Residence permit',
            when: 'After you have an admission',
            rows: [
              ('Application fee', _residencePermit, null),
              ('Police clearance certificate legalisation', _pccLegalisation,
                  null),
              ('Travel health insurance, Sanlam', null, '\u20A630,000'),
            ],
            note: 'The police clearance certificate is legalised separately '
                'from your other documents, paid at the embassy on this same '
                'day. Time it to start about two weeks before this '
                'appointment, since it expires after three months. Travel '
                'insurance here is not \u00D6GK \u2014 \u00D6GK only starts '
                'once you have arrived.',
          ),

          _Stage(
            title: 'D visa',
            when: 'Only after the permit is approved',
            rows: [
              ('Visa fee', _dVisa, null),
            ],
          ),

          _Stage(
            title: 'First year at university',
            when: 'After you arrive',
            rows: [
              ('Tuition, public university', _tuitionPerYear, null),
              ('\u00D6H fee, two semesters', _ohPerSemester * 2, null),
            ],
            note: 'Every public university charges the same. Applied sciences '
                'schools vary, so check the Schools tab.',
          ),

          const SizedBox(height: 8),
          Callout(
            text: 'Proof of funds is separate from all of this. It is money '
                'you show the embassy, not money you spend: twelve months '
                'proven in advance, and you must be able to show where it came '
                'from. If your rent runs above \u20AC386.43 a month you need '
                'extra on top.',
            icon: Icons.account_balance_outlined,
          ),
          const SizedBox(height: 14),
          Text(
            'Estimates, not quotes. Fees change and the embassy has the final '
            'word. Flights, accommodation, translation and living costs are '
            'not included here.',
            style: TextStyle(fontSize: 12, height: 1.55, color: p.inkMuted),
          ),
        ],
      ),
    );
  }
}

class _Stage extends StatelessWidget {
  final String title;
  final String when;

  /// Each row is (label, euroAmount, preFormattedValue). Pass an euro
  /// amount for figures that should convert to Naira automatically, or
  /// leave it null and supply preFormattedValue for a figure that is
  /// already in Naira (like the Sanlam insurance quote).
  final List<(String, double?, String?)> rows;
  final String? note;

  const _Stage({
    required this.title,
    required this.when,
    required this.rows,
    this.note,
  });

  static String _fmtEur(double amount) {
    if (amount == amount.roundToDouble()) return '\u20AC${amount.round()}';
    return '\u20AC${amount.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final rates = context.watch<ExchangeRateService>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 3),
              Text(
                when,
                style: TextStyle(fontSize: 12, color: p.inkMuted),
              ),
              const SizedBox(height: 14),
              ...rows.map((r) {
                final label = r.$1;
                final eurAmount = r.$2;
                final preFormatted = r.$3;
                final valueText =
                    eurAmount != null ? _fmtEur(eurAmount) : preFormatted!;
                final nairaText = eurAmount != null
                    ? rates.nairaEquivalent(eurAmount)
                    : null;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(label,
                            style: TextStyle(
                                fontSize: 13.5, color: p.inkMuted)),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            valueText,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                          if (nairaText != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              '\u2248 $nairaText',
                              style: TextStyle(
                                  fontSize: 11.5, color: p.inkMuted),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              }),
              if (note != null) ...[
                const SizedBox(height: 4),
                Text(
                  note!,
                  style: TextStyle(
                      fontSize: 12, height: 1.5, color: p.inkMuted),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Shows today's reference rate, so the Naira figures on this screen have a
/// visible source rather than appearing from nowhere.
class _RateBanner extends StatelessWidget {
  const _RateBanner();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final rates = context.watch<ExchangeRateService>();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: p.accentSoft,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.sync_alt, size: 16, color: p.accent),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rates.hasNoRate
                      ? 'Naira figures need an internet connection the '
                          'first time'
                      : '${rates.rateLabel}  \u00B7  ${rates.updatedLabel}',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: p.accent,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'A market rate, for planning only. The embassy and VFS '
                  'set their own rate on the day you pay, and it will not '
                  'match this exactly.',
                  style: TextStyle(fontSize: 11, height: 1.4, color: p.accent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
      );
}

class _Choice extends StatelessWidget {
  final bool selected;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _Choice({
    required this.selected,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(11),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected ? p.accentSoft : p.card,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: selected ? p.accent : p.line,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                size: 19,
                color: selected ? p.accent : p.inkMuted,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style:
                            TextStyle(fontSize: 12, color: p.inkMuted)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Check extends StatelessWidget {
  final bool value;
  final String title;
  final String subtitle;
  final ValueChanged<bool> onChanged;

  const _Check({
    required this.value,
    required this.title,
    required this.subtitle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(11),
        onTap: () => onChanged(!value),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: value ? p.accentSoft : p.card,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: value ? p.accent : p.line,
              width: value ? 1.5 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                value ? Icons.check_box : Icons.check_box_outline_blank,
                size: 20,
                color: value ? p.accent : p.inkMuted,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 3),
                    Text(subtitle,
                        style: TextStyle(
                            fontSize: 12, height: 1.45, color: p.inkMuted)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const _Stepper({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Container(
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: p.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: value > 0 ? () => onChanged(value - 1) : null,
            icon: const Icon(Icons.remove, size: 19),
            color: p.accent,
          ),
          SizedBox(
            width: 34,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          IconButton(
            onPressed: value < 8 ? () => onChanged(value + 1) : null,
            icon: const Icon(Icons.add, size: 19),
            color: p.accent,
          ),
        ],
      ),
    );
  }
}
