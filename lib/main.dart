import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'core/di/injection.dart';
import 'core/config/env_config.dart';
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

const String syncTask = "tugas_sinkronisasi_rutin";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == syncTask) {
      try {

        // Pura-pura butuh waktu 3 detik
        await Future.delayed(const Duration(seconds: 3));

        // --- TUGAS SELESAI ---
        // Catat jam berapa tugas ini berhasil dikerjakan ke memori HP
        final prefs = await SharedPreferences.getInstance();
        String currentTime = DateFormat(
          'dd MMM yyyy, HH:mm:ss',
        ).format(DateTime.now());
        await prefs.setString(
          "last_sync_time",
          "Sinkronisasi diam-diam sukses pada: $currentTime",
        );

      } catch (e) {
        return Future.value(false); // Lapor ke OS kalau gagal
      }
    }
    return Future.value(true); // Lapor ke OS kalau sukses!
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(callbackDispatcher);

  setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: EnvConfig.showDebugBanner,
      title: 'UTD Advanced App',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
