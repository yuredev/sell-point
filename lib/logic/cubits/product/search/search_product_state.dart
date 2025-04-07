import 'package:equatable/equatable.dart';
import 'package:sell_point/domain/product/product.dart';

abstract class SearchProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchProductInitial extends SearchProductState {}

class SearchingProductState extends SearchProductState {}

class ProductFoundState extends SearchProductState {
  final Product product;

  ProductFoundState(this.product);

  @override
  List<Object?> get props => [product];
}

class SearchProductError extends SearchProductState {
  final bool isNetworkError;

  SearchProductError(this.isNetworkError);

  @override
  List<Object?> get props => [isNetworkError];
}
