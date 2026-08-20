import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/purchase_service.dart';
import '../theme.dart';
import '../widgets/common.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  final _codeController = TextEditingController();
  bool _codeInvalid = false;
  bool _checkingCode = false;

  static const _included = [
    (
      'All nineteen steps, in the right order',
      'Including which ones run at the same time, which is where most people '
          'lose months.'
    ),
    (
      'Every document, listed by stage',
      'What you need, when, and which ones adults cannot substitute.'
    ),
    (
      'Costs worked out for your situation',
      'Based on your education level and whether family are coming with you.'
    ),
    (
      'Schools under \u20AC2,000 a year',
      'With their English programmes, and the deposits some ask for before '
          'they will send an acceptance letter.'
    ),
    (
      'Our Abuja team',
      'Send your documents instead of flying there. Contact details included.'
    ),
    (
      'The traps',
      'Police clearance expiry, permit before visa, deposits that are not '
          'refundable.'
    ),
  ];

  Future<void> _applyCode() async {
    final code = _codeController.text;
    if (code.trim().isEmpty) return;
    setState(() => _checkingCode = true);
    final ok = await context.read<PurchaseService>().applyReferralCode(code);
    setState(() {
      _checkingCode = false;
      _codeInvalid = !ok;
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final purchases = context.watch<PurchaseService>();

    return Scaffold(
      appBar: AppBar(actions: const [ThemeToggle(), SizedBox(width: 6)]),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(22, 0, 22, 32),
        children: [
          const Text(
            'The whole route,\nwritten down',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'One payment, and it stays unlocked. Written by someone who went '
            'through every stage of this and lives in Austria now.',
            style: TextStyle(fontSize: 15, height: 1.6, color: p.inkMuted),
          ),
          const SizedBox(height: 28),
          ..._included.map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline, color: p.accent, size: 19),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          b.$1,
                          style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              height: 1.35),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          b.$2,
                          style: TextStyle(
                              fontSize: 13,
                              height: 1.5,
                              color: p.inkMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          if (purchases.hasReferralDiscount)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: p.okBg,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Row(
                children: [
                  Icon(Icons.local_offer_outlined, size: 18, color: p.ok),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '20% off applied \u2014 referred by '
                      '${purchases.referralFriendName}',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: p.ok,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 17, color: p.ok),
                    onPressed: () {
                      context.read<PurchaseService>().clearReferralCode();
                      _codeController.clear();
                      setState(() => _codeInvalid = false);
                    },
                  ),
                ],
              ),
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _codeController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      hintText: 'Referral code (optional)',
                      hintStyle: TextStyle(fontSize: 13.5, color: p.inkMuted),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 13),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: BorderSide(color: p.line),
                      ),
                      errorText: _codeInvalid ? 'Code not recognised' : null,
                    ),
                    onSubmitted: (_) => _applyCode(),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 46,
                  child: OutlinedButton(
                    onPressed: _checkingCode ? null : _applyCode,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: p.accent,
                      side: BorderSide(color: p.accent.withValues(alpha: 0.4)),
                    ),
                    child: _checkingCode
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Apply'),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          if (purchases.errorMessage != null) ...[
            Callout(
              text: purchases.errorMessage!,
              icon: Icons.error_outline,
            ),
            const SizedBox(height: 16),
          ],
          FilledButton(
            onPressed: purchases.isLoading
                ? null
                : () async {
                    final ok = await context.read<PurchaseService>().purchase();
                    if (ok && context.mounted) Navigator.of(context).pop();
                  },
            child: purchases.isLoading
                ? const SizedBox(
                    width: 21,
                    height: 21,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    purchases.displayPrice == null
                        ? 'Unlock the guide'
                        : 'Unlock for ${purchases.displayPrice}',
                  ),
          ),
          const SizedBox(height: 6),
          TextButton(
            onPressed: purchases.isLoading
                ? null
                : () async {
                    final ok = await context.read<PurchaseService>().restore();
                    if (ok && context.mounted) Navigator.of(context).pop();
                  },
            child: const Text('Already paid? Restore it'),
          ),
          const SizedBox(height: 16),
          Text(
            'This is guidance from personal experience, not legal or '
            'immigration advice. Rules and fees change. Confirm anything that '
            'matters with the Austrian embassy and the school you are applying '
            'to.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, height: 1.55, color: p.inkMuted),
          ),
        ],
      ),
    );
  }
}
