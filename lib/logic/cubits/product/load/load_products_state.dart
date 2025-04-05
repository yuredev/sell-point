import 'package:equatable/equatable.dart';
import 'package:sell_point/domain/product/product.dart';

abstract class LoadProductsState {}

class InitialLoadProductsState extends LoadProductsState {}

class LoadingProductsState extends Equatable implements LoadProductsState {
  @override
  List<Object?> get props => [];
}

class ProductsLoadedState extends Equatable implements LoadProductsState {
  final List<Product> products;

  const ProductsLoadedState(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductsLoadErrorState extends Equatable implements LoadProductsState {
  final bool isConnectionError;

  const ProductsLoadErrorState({
    required this.isConnectionError,
  });

  @override
  List<Object?> get props => [isConnectionError];
}
