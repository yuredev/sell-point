import 'package:dio/dio.dart' show DioException;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sell_point/core/constants/durations.dart';
import 'package:sell_point/domain/product/product.dart';
import 'package:sell_point/logic/cubits/product/load/load_products_state.dart';
import 'package:sell_point/repository/product/product_repository.dart';
import 'package:sell_point/utils/date_time_utils.dart';

class LoadProductsCubit extends HydratedCubit<LoadProductsState> {
  final ProductRepository productRepository;

  LoadProductsCubit({required this.productRepository})
    : super(InitialLoadProductsState());

  List<Product> get products {
    if (state is! ProductsLoadedState) {
      return [];
    }
    return (state as ProductsLoadedState).products;
  }

  bool get shouldRefresh {
    if (state is! ProductsLoadedState) {
      return true;
    }
    return DateTime.now()
        .subtract(Duration(minutes: Durations.minutesRefreshRate))
        .isAfter((state as ProductsLoadedState).lastTimeUpdated);
  }

  Future<void> load() async {
    try {
      emit(LoadingProductsState());
      final products = await productRepository.getAll();
      final now = DateTime.now();
      emit(ProductsLoadedState(products, now));
    } catch (e) {
      print(e);
      emit(ProductsLoadErrorState(isConnectionError: e is DioException));
    }
  }

  @override
  LoadProductsState? fromJson(Map<String, dynamic> json) {
    try {
      final products =
          (json['products'] as List).map((e) => Product.fromJson(e)).toList();
      final lastTimeUpdated = DateTimeUtils.fromBRLFormat(
        json['lastTimeUpdated'],
      );
      return ProductsLoadedState(products, lastTimeUpdated);
    } catch (_) {
      return InitialLoadProductsState();
    }
  }

  @override
  Map<String, dynamic>? toJson(LoadProductsState state) {
    if (state is ProductsLoadedState) {
      return {
        'products': state.products.map((e) => e.toJson()).toList(),
        'lastTimeUpdated': DateTimeUtils.dateToBRLFormat(state.lastTimeUpdated),
      };
    }
    return null;
  }
}
