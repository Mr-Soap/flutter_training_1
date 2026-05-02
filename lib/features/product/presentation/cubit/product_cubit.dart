import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_state.dart';
import '../../domain/product_service.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductService _service;
  ProductCubit(this._service) : super(ProductLoading());

  Future<void> fetchAllProducts() async {
    emit(ProductLoading());

    try {
      // minta data
      final data = await _service.fetchProducts();

      //jika berhasil emit state sukses dan datanya
      emit(ProductLoaded(data));
    } catch (e) {
      //jika error emit state error
      emit(ProductError('Gagal memuat product: $e'));
    }
  }
}
