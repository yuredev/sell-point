
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/logic/cubits/cart/action/create_cart_state.dart';
import 'package:sell_point/domain/cart/cart.dart';
import 'package:sell_point/repository/cart/cart_repository.dart';

class CreateCartCubit extends Cubit<CreateCartState> {
  final CartRepository cartRepository;

  CreateCartCubit({required this.cartRepository}) : super(InitialCreateCartState());

  Future<void> create(Cart cart) async {
    try {
      emit(CreatingCartState());
      await cartRepository.create(cart);
      emit(CartCreatedState());
    } catch (e) {
      print(e);
      emit(CartCreateErrorState(isConnectionError: e is DioException));
    }
  }
}
