import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiClient {
  final Dio dio;
  final Logger logger = Logger();

  ApiClient() : dio = Dio() {
    // 1. Konfigurasi Dasar (Global)
    dio.options.baseUrl = 'https://fakestoreapi.com';
    dio.options.connectTimeout = const Duration(seconds: 10); // Maksimal tunggu 10 detik
    dio.options.receiveTimeout = const Duration(seconds: 10);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          logger.i('MENGIRIM REQUEST: [${options.method}] ${options.uri}');
          // Di sinilah nanti Anda memasukkan Token jika API butuh login
          return handler.next(options); // Lanjutkan request
        },
        onResponse: (response, handler) {
          logger.i('V BERHASIL [${response.statusCode}]: ${response.requestOptions.uri}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          logger.e('X ERROR [${e.response?.statusCode}]: ${e.requestOptions.uri}');
          logger.e('PESAN: ${e.message}');
          return handler.next(e); // Lanjutkan error agar ditangkap oleh aplikasi
        },
      ),
    );
  }
}