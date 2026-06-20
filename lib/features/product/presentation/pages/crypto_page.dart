import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  //variable
  late WebSocketChannel _channel;

  @override
  void initState() {
    super.initState();
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://ws.coincap.io/prices?assets=bitcoin'),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Harga Bitcoin'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: StreamBuilder(
        stream: _channel.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Koneksi Terputus!'));
          }

          final String dataString = snapshot.data as String;
          final Map<String, dynamic> dataJson = jsonDecode(dataString);

          final String currentPrice = dataJson['bitcoin'] ?? '0.00';

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.currency_bitcoin,
                  size: 100,
                  color: Colors.orange,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Harga BTC/USD saat ini',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '\$ $currentPrice',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 40),

                //indikator
                const CircularProgressIndicator(),
                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    //fungsi berat
                    // ignore: unused_local_variable
                    int hasil = 0;

                    //looping 4 milyar kali
                    for (int i = 0; i < 4000000000; i++) {
                      hasil += i;
                    }
                  },
                  child: const Text(
                    'Siksa Main Thread (Layar akan Macet!)',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 10),
                
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                    // ignore: unused_local_variable
                    int hasil = await compute(tugasMenghitungBerat, 4000000000);
                  },
                  child: const Text(
                    'Gunakan Isolate (Layar Tetap Lancar)',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

int tugasMenghitungBerat(int jumlahLooping) {
  int hasil = 0;
  for (int i = 0; i < jumlahLooping; i++) {
    hasil += i;
  }
  return hasil;
}
