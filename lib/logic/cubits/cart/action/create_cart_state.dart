
import 'package:equatable/equatable.dart';

abstract class CreateCartState {}

class InitialCreateCartState extends CreateCartState {}

class CreatingCartState extends Equatable implements CreateCartState {
  @override
  List<Object?> get props => [];
}

class CartCreatedState extends Equatable implements CreateCartState {
  @override
  List<Object?> get props => [];
}

class CartCreateErrorState extends Equatable implements CreateCartState {
  final bool isConnectionError;

  const CartCreateErrorState({required this.isConnectionError});

  @override
  List<Object?> get props => [isConnectionError];
}
