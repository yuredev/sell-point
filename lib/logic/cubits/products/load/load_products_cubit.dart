// ignore_for_file: avoid_print

import 'package:dio/dio.dart' show DioException;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/logic/cubits/products/load/load_products_state.dart';
import 'package:sell_point/repository/product/product_repository.dart';

class LoadProductsCubit extends Cubit<LoadProductsState> {
  final ProductRepository productRepository;

  LoadProductsCubit({required this.productRepository})
      : super(InitialLoadProductsState());

  Future<void> load() async {
    try {
      emit(LoadingProductsState());
      final products = await productRepository.getAll();
      emit(ProductsLoadedState(products));
    } catch (e) {
      print(e);
      emit(ProductsLoadErrorState(isConnectionError: e is DioException));
    }
  }
}