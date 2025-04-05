// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/logic/cubits/cart/load/load_carts_state.dart';
import 'package:sell_point/repository/cart/cart_repository.dart';

class LoadCartsCubit extends Cubit<LoadCartsState> {
  final CartRepository cartRepository;

  LoadCartsCubit({required this.cartRepository})
    : super(InitialLoadCartsState());

  Future<void> load() async {
    try {
      emit(LoadingCartsState());
      final carts = await cartRepository.getAll();
      emit(CartsLoadedState(carts));
    } catch (e) {
      print(e);
      emit(CartsLoadErrorState(isConnectionError: e is DioException));
    }
  }
}
