import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _spinController;
  late AnimationController _lottieController;

  final double _dragSensitivity = 300;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _spinController.repeat();
    // Inisialisasi controller Lottie
    _lottieController = AnimationController(
      vsync: this,
      // Durasi tidak diisi karena kita akan mengikuti durasi asli dari desainer
    );
  }

  @override
  void dispose() {
    _spinController.dispose();
    _lottieController.dispose(); // Jangan lupa hancurkan yang ini juga
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advanced Animations')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Explicit Animation (Putaran Tanpa Henti):",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // AnimatedBuilder akan digambar ulang 60 kali/detik
            // selama _spinController berjalan
            AnimatedBuilder(
              animation: _spinController,
              builder: (context, child) {
                return Transform.rotate(
                  // Nilai _spinController.value bergerak dari 0.0 sampai 1.0.
                  // Kita kalikan dengan 6.28 (2 x Pi) karena putaran menggunakan hitungan Radian (Derajat).
                  angle: _spinController.value * 6.2831853,
                  child: child, // Ini merujuk ke Icon Bintang di bawah
                );
              },
              // Child diletakkan di sini agar Icon tidak perlu di-rebuild dari nol 60x/detik,
              // cukup dirotasi saja (sangat menghemat CPU).
              child: const Icon(Icons.star, size: 100, color: Colors.orange),
            ),

            const SizedBox(height: 50),

            const Divider(),

            const Text(
              "Lottie Integration (Animasi Desainer):",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onPanUpdate: (details) {
                // delta.dx = pergeseran horizontal jari
                double delta = details.delta.dx;

                // Ubah nilai controller berdasarkan geseran jari
                _lottieController.value += delta / _dragSensitivity;

                // Pastikan nilainya tetap antara 0.0 sampai 1.0
                if (_lottieController.value < 0.0) {
                  _lottieController.value = 0.0;
                }

                if (_lottieController.value > 1.0) {
                  _lottieController.value = 1.0;
                }
              },

              child: Column(
                children: [
                  // Memanggil file animasi JSON langsung dari URL internet
                  Lottie.network(
                    'https://assets10.lottiefiles.com/packages/lf20_jbrw3hcz.json',

                    width: 150,
                    height: 150,

                    controller: _lottieController,

                    onLoaded: (composition) {
                      _lottieController.duration = composition.duration;
                    },
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Geser kanan/kiri untuk Scrubbing Animasi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                        ),

                        onPressed: () {
                          _lottieController.reset();
                          _lottieController.forward();
                        },

                        child: const Text("Forward"),
                      ),

                      const SizedBox(width: 20),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),

                        onPressed: () {
                          _lottieController.value = 1.0;
                          _lottieController.reverse();
                        },

                        child: const Text("Reverse"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
