import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/logic/cubits/product/search/search_product_state.dart';
import 'package:sell_point/repository/product/product_repository.dart';

class SearchProductCubit extends Cubit<SearchProductState> {
  final ProductRepository productRepository;

  SearchProductCubit({required this.productRepository}) : super(SearchProductInitial());

  Future<void> search(int id) async {
    emit(SearchingProductState());
    try {
      final product = await productRepository.getById(id);
      emit(ProductFoundState(product));
    } catch (e) {
      emit(SearchProductError(e is DioException));
    }
  }

  void clear() {
    emit(SearchProductInitial());
  }
}
