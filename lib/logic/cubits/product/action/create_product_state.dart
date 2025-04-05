
import 'package:equatable/equatable.dart';

abstract class CreateProductState {}

class InitialCreateProductState extends CreateProductState {}

class CreatingProductState extends Equatable implements CreateProductState {
  @override
  List<Object?> get props => [];
}

class ProductCreatedState extends Equatable implements CreateProductState {
  @override
  List<Object?> get props => [];
}

class ProductCreateErrorState extends Equatable implements CreateProductState {
  final bool isConnectionError;

  const ProductCreateErrorState({required this.isConnectionError});

  @override
  List<Object?> get props => [isConnectionError];
}
