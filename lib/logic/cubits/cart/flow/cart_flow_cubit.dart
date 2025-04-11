import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sell_point/domain/dto/cart_product_dto/cart_product_dto.dart';
import 'package:sell_point/logic/cubits/cart/flow/cart_flow_state.dart';

class CartFlowCubit extends HydratedCubit<CartFlowState> {
  CartFlowCubit() : super(CartFlowInitialState());

  void reset() => emit(CartFlowInitialState());

  void addToCart(List<CartProductDto> dtos) {
    final updatedList = <CartProductDto>[];
    if (state is AddingProductsState) {
      final current = (state as AddingProductsState).dtos;
      final updatedMap = {for (var d in current) d.productId: d};
      for (final dto in dtos) {
        updatedMap[dto.productId] = dto;
      }
      updatedList.addAll(updatedMap.values);
    } else {
      updatedList.addAll(dtos);
    }
    emit(AddingProductsState(updatedList));
  }

  @override
  CartFlowState fromJson(Map<String, dynamic> json) {
    final cartsJson = json['carts'];
    if (cartsJson == null) {
      return CartFlowInitialState();
    } else {
      final carts =
          List<Map<String, dynamic>>.from(
            cartsJson,
          ).map((e) => CartProductDto.fromJson(e)).toList();
      return AddingProductsState(carts);
    }
  }

  @override
  Map<String, dynamic>? toJson(CartFlowState state) {
    if (state is AddingProductsState) {
      return {'carts': state.dtos.map((c) => c.toJson()).toList()};
    }
    return null;
  }
}
