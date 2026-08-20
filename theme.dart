import 'package:flutter/material.dart';

/// Palette: muted slate-blues and a soft teal, chosen to stay easy on the eyes
/// during long reading sessions. Amber is reserved for warnings only, so they
/// keep their weight against the calmer background.
class AppPalette {
  final Color accent;
  final Color accentSoft;
  final Color ink;
  final Color inkMuted;
  final Color bg;
  final Color card;
  final Color line;
  final Color warn;
  final Color warnBg;
  final Color ok;
  final Color okBg;
  final Color heroFrom;
  final Color heroTo;

  const AppPalette({
    required this.accent,
    required this.accentSoft,
    required this.ink,
    required this.inkMuted,
    required this.bg,
    required this.card,
    required this.line,
    required this.warn,
    required this.warnBg,
    required this.ok,
    required this.okBg,
    required this.heroFrom,
    required this.heroTo,
  });

  static const light = AppPalette(
    accent: Color(0xFF3E7C8A),
    accentSoft: Color(0xFFE8F1F3),
    ink: Color(0xFF223038),
    inkMuted: Color(0xFF6B7C86),
    bg: Color(0xFFF6F8F8),
    card: Colors.white,
    line: Color(0xFFE3E9EB),
    warn: Color(0xFF9A6218),
    warnBg: Color(0xFFFBF1DF),
    ok: Color(0xFF3F7A5C),
    okBg: Color(0xFFE6F2EB),
    heroFrom: Color(0xFF2C4652),
    heroTo: Color(0xFF35555F),
  );

  static const dark = AppPalette(
    accent: Color(0xFF7FB6C2),
    accentSoft: Color(0xFF1E3138),
    ink: Color(0xFFE6EDEF),
    inkMuted: Color(0xFF93A4AD),
    bg: Color(0xFF141C21),
    card: Color(0xFF1C262C),
    line: Color(0xFF2A373E),
    warn: Color(0xFFE0B265),
    warnBg: Color(0xFF33291A),
    ok: Color(0xFF7FBC98),
    okBg: Color(0xFF1B2C23),
    heroFrom: Color(0xFF16232A),
    heroTo: Color(0xFF1E3038),
  );
}

extension PaletteContext on BuildContext {
  AppPalette get palette => Theme.of(this).brightness == Brightness.dark
      ? AppPalette.dark
      : AppPalette.light;
}

ThemeData buildTheme(Brightness brightness) {
  final p = brightness == Brightness.dark ? AppPalette.dark : AppPalette.light;
  final base = ThemeData(brightness: brightness, useMaterial3: true);

  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: p.accent,
      brightness: brightness,
      primary: p.accent,
      surface: p.bg,
    ),
    scaffoldBackgroundColor: p.bg,
    appBarTheme: AppBarTheme(
      backgroundColor: p.bg,
      foregroundColor: p.ink,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: p.ink,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
      ),
    ),
    cardTheme: CardThemeData(
      color: p.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: p.line),
      ),
      margin: EdgeInsets.zero,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: p.accent,
        foregroundColor:
            brightness == Brightness.dark ? const Color(0xFF10191D) : Colors.white,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: p.accent),
    ),
    dividerTheme: DividerThemeData(color: p.line, thickness: 1, space: 1),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: p.card,
      surfaceTintColor: Colors.transparent,
      indicatorColor: p.accentSoft,
      elevation: 0,
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500, color: p.inkMuted),
      ),
    ),
    textTheme: base.textTheme.apply(bodyColor: p.ink, displayColor: p.ink),
  );
}
