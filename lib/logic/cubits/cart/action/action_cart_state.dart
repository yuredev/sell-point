
import 'package:equatable/equatable.dart';

abstract class ActionCartState {}

class InitialActionCartState extends ActionCartState {}

class SavingCartState extends Equatable implements ActionCartState {
  @override
  List<Object?> get props => [];
}

class CartSavedState extends Equatable implements ActionCartState {
  @override
  List<Object?> get props => [];
}

class SaveProductErrorState extends Equatable implements ActionCartState {
  final bool isConnectionError;

  const SaveProductErrorState({required this.isConnectionError});

  @override
  List<Object?> get props => [isConnectionError];
}
