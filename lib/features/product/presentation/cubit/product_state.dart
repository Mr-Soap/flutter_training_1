import 'package:equatable/equatable.dart';
import '../../domain/product_model.dart';

abstract class ProductState extends Equatable{
  const ProductState();

  @override
  List<Object> get props => [];
}

// indikator awal
class ProductLoading extends ProductState{}

// indikator sukses
class ProductLoaded extends ProductState{
  final List<Product> products;

  const ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

//indikator error
class ProductError extends ProductState{
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}