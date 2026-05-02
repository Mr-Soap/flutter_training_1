import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/product/presentation/pages/crypto_page.dart';
import '../../features/product/presentation/pages/product_page.dart';
import '../../features/product/presentation/pages/detail_page.dart';
import '../../features/product/presentation/pages/profile_page.dart';
import '../../features/product/presentation/cubit/product_cubit.dart';
import '../../features/todo/presentation/pages/todo_page.dart';
import '../../features/native/presentation/pages/native_page.dart';
import '../di/injection.dart';

class AppRouter {
  // Mendefinisikan konfigurasi Router utama
  static final router = GoRouter(
    initialLocation: '/', // Saat aplikasi dibuka, mulai dari path '/'

    routes: [
      GoRoute(
        path: '/', // Path beranda
        builder: (context, state) {
          return BlocProvider(
            create: (context) => locator<ProductCubit>()..fetchAllProducts(),
            child: const ProductPage(),
          );
        },
      ),
      GoRoute(
        path: '/detail/:id',
        builder: (context, state) {
          final productId = state.pathParameters['id'] ?? '';
          return DetailPage(productId: productId);
        },
      ),

      GoRoute(path: '/crypto', builder: (context, state) => const CryptoPage()),

      GoRoute(path: '/todo', builder: (context, state) => const TodoPage()),

      GoRoute(
        path: '/native',
        builder: (context, state) => const NativePage(),
      ),

      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error 404')),
      body: Center(child: Text('Halaman tidak ditemukan!')),
    ),
  );
}
