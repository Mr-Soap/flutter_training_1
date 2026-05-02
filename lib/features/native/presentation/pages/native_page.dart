import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativePage extends StatefulWidget {
  const NativePage({super.key});

  @override
  State<NativePage> createState() => _NativePageState();
}

class _NativePageState extends State<NativePage> {
  static const platform = MethodChannel('utd.ac.id/native_jembatan');
  String _batteryLevel = 'Baterai belum dicek.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Sisa baterai anda: $result %';
    } on PlatformException catch (e) {
      batteryLevel = "Gagal membaca baterai: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<void> _showNativeToast() async {
    try {
      await platform.invokeMethod('showToast', {
        "pesan": "Halo, ini pesan dari Dunia Dart!"
      });
    } on PlatformException catch (e) {
      debugPrint("Gagal Toast: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Integrasi Native Kotlin')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_batteryLevel, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _getBatteryLevel,
              child: const Text('Cek Baterai (via Kotlin)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: _showNativeToast,
              child: const Text('Munculkan Native Toast', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}