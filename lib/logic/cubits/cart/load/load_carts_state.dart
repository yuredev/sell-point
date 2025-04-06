import 'package:equatable/equatable.dart';
import 'package:sell_point/domain/cart/cart.dart';

abstract class LoadCartsState {}

class InitialLoadCartsState extends LoadCartsState {}

class LoadingCartsState extends Equatable implements LoadCartsState {
  @override
  List<Object?> get props => [];
}

class CartsLoadedState extends Equatable implements LoadCartsState {
  final List<Cart> carts;
  final DateTime lastTimeUpdated;

  const CartsLoadedState(this.carts, this.lastTimeUpdated);

  @override
  List<Object?> get props => [carts];
}

class CartsLoadErrorState extends Equatable implements LoadCartsState {
  final bool isConnectionError;

  const CartsLoadErrorState({
    required this.isConnectionError,
  });

  @override
  List<Object?> get props => [isConnectionError];
}
