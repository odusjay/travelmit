import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/settings_service.dart';
import '../theme.dart';

/// Sun/moon button for the app bar.
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return IconButton(
      tooltip: isDark ? 'Switch to light' : 'Switch to dark',
      icon: Icon(
        isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        size: 21,
      ),
      color: context.palette.inkMuted,
      onPressed: () => context.read<SettingsService>().toggle(brightness),
    );
  }
}

/// Coloured callout used for warnings and asides.
class Callout extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool warning;

  const Callout({
    super.key,
    required this.text,
    this.icon = Icons.info_outline,
    this.warning = true,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final bg = warning ? p.warnBg : p.accentSoft;
    final fg = warning ? p.warn : p.accent;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 17, color: fg),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.5,
                color: fg,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Small outlined label.
class Pill extends StatelessWidget {
  final String text;
  final Color? color;

  const Pill({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: p.bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: p.line),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: color ?? p.inkMuted),
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String text;
  const SectionHeading(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
      );
}

/// Splits text on blank lines into spaced paragraphs.
class Prose extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;

  const Prose(this.text, {super.key, this.size = 14.5, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: text
          .split('\n\n')
          .map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  p,
                  style: TextStyle(fontSize: size, height: 1.6, color: color),
                ),
              ))
          .toList(),
    );
  }
}

Future<void> openUrl(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

Future<void> openEmail(String address, {String subject = ''}) async {
  final uri = Uri(
    scheme: 'mailto',
    path: address,
    query: subject.isEmpty ? null : 'subject=${Uri.encodeComponent(subject)}',
  );
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}
