import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/domain/product/product.dart';
import 'package:sell_point/logic/cubits/product/action/create_product_state.dart';
import 'package:sell_point/repository/product/product_repository.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  final ProductRepository productRepository;

  CreateProductCubit({required this.productRepository}) : super(InitialCreateProductState());

  Future<void> create(Product product) async {
    try {
      emit(CreatingProductState());
      await productRepository.create(product);
      emit(ProductCreatedState());
    } catch (e) {
      print(e);
      emit(ProductCreateErrorState(isConnectionError: e is DioException));
    }
  }
}
