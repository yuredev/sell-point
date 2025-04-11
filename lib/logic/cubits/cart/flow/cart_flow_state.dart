import 'package:equatable/equatable.dart';
import 'package:sell_point/domain/dto/cart_product_dto/cart_product_dto.dart';

abstract class CartFlowState extends Equatable {}

class UserCartDTO {}

class CartFlowInitialState extends CartFlowState {
  @override
  List<Object?> get props => [];
}


class AddingProductsState extends CartFlowState {
  final List<CartProductDto> dtos;

  AddingProductsState(this.dtos);

  @override
  List<Object?> get props => [dtos];
}
