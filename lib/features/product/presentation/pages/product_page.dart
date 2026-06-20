import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import '../../../../core/config/env_config.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            context.push('/profile');
          },
        ),
        title: Text('Katalog UTD [${EnvConfig.environment}]'),
        backgroundColor: EnvConfig.isProduction
            ? Colors.green.shade800
            : Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.checklist),
            onPressed: () {
              context.push('/todo');
            },
          ),

          IconButton(
            icon: const Icon(Icons.animation),
            onPressed: () {
              context.push('/animation');
            },
          ),

          IconButton(
            icon: const Icon(Icons.cloud),
            onPressed: () {
              context.push('/sync');
            },
          ),
        ],
      ),

      //blocbuilder
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          // jika state loading
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          //jika state error
          else if (state is ProductError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          //jika state sukses
          else if (state is ProductLoaded) {
            final products = state.products;

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final item = products[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: Image.network(
                      item.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    ),
                    title: Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text('ID: ${item.id}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      context.push('/detail/${item.id}');
                    },
                  ),
                );
              },
            );
          }
          // fallback jika state unknown
          return const SizedBox.shrink();
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/crypto');
        },
        icon: const Icon(Icons.show_chart),
        label: const Text('Live Crypto'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
