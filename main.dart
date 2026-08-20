import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/discover_content.dart';
import 'services/purchase_service.dart';
import 'services/progress_service.dart';
import 'services/settings_service.dart';
import 'services/exchange_rate_service.dart';
import 'screens/home_screen.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TravelMitApp());
}

class TravelMitApp extends StatelessWidget {
  const TravelMitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsService()..init()),
        ChangeNotifierProvider(create: (_) => PurchaseService()..init()),
        ChangeNotifierProvider(create: (_) => ProgressService()..init()),
        ChangeNotifierProvider(create: (_) => ExchangeRateService()..init()),
      ],
      child: Consumer<SettingsService>(
        builder: (context, settings, _) => MaterialApp(
          title: appName,
          debugShowCheckedModeBanner: false,
          theme: buildTheme(Brightness.light),
          darkTheme: buildTheme(Brightness.dark),
          themeMode: settings.themeMode,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
