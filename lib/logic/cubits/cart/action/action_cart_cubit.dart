import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/domain/dto/cart_dto/cart_dto.dart';
import 'package:sell_point/logic/cubits/cart/action/action_cart_state.dart';
import 'package:sell_point/logic/cubits/cart/flow/cart_flow_cubit.dart';
import 'package:sell_point/repository/cart/cart_repository.dart';

class ActionCartCubit extends Cubit<ActionCartState> {
  final CartRepository cartRepository;
  final CartFlowCubit cartFlowCubit;

  ActionCartCubit({required this.cartRepository, required this.cartFlowCubit})
    : super(InitialActionCartState());

  Future<void> save(CartDto dto) async {
    try {
      emit(SavingCartState());
      await cartRepository.save(dto.id, dto);
      emit(CartSavedState());
      cartFlowCubit.reset();
    } catch (e) {
      print(e);
      emit(SaveProductErrorState(isConnectionError: e is DioException));
    }
  }
}
