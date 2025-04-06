import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sell_point/core/constants/durations.dart';
import 'package:sell_point/domain/cart/cart.dart';
import 'package:sell_point/domain/dto/cart_dto/cart_dto.dart';
import 'package:sell_point/domain/product/product.dart';
import 'package:sell_point/domain/user/user.dart';
import 'package:sell_point/logic/cubits/cart/load/load_carts_state.dart';
import 'package:sell_point/logic/cubits/product/load/load_products_cubit.dart';
import 'package:sell_point/logic/cubits/user/load/load_users_cubit.dart';
import 'package:sell_point/logic/cubits/user/load/load_users_state.dart';
import 'package:sell_point/repository/cart/cart_repository.dart';
import 'package:sell_point/utils/date_time_utils.dart';

extension CartDtoMapper on CartDto {
  Cart toModel(List<Product> allProducts, List<User> allUsers) {
    final mappedProducts =
        products.map((pDTO) {
          return allProducts.firstWhere((p) => p.id == pDTO.productId);
        }).toList();
    final user = allUsers.firstWhere((u) => u.id == userId);
    return Cart(id: id, user: user, products: mappedProducts);
  }
}

class LoadCartsCubit extends HydratedCubit<LoadCartsState> {
  final CartRepository cartRepository;
  final LoadProductsCubit loadProductsCubit;
  final LoadUsersCubit loadUsersCubit;

  LoadCartsCubit({
    required this.loadUsersCubit,
    required this.loadProductsCubit,
    required this.cartRepository,
  }) : super(InitialLoadCartsState());

  bool get shouldRefresh {
    if (state is! CartsLoadedState) {
      return true;
    }
    return DateTime.now()
        .subtract(Duration(minutes: Durations.minutesRefreshRate))
        .isAfter((state as UsersLoadedState).lastTimeUpdated);
  }

  Future<void> load() async {
    try {
      assert(
        loadProductsCubit.products.isNotEmpty &&
            loadUsersCubit.users.isNotEmpty,
      );
      emit(LoadingCartsState());
      final cartsDTOs = await cartRepository.getAll();
      final carts =
          cartsDTOs
              .map(
                (dto) => dto.toModel(
                  loadProductsCubit.products,
                  loadUsersCubit.users,
                ),
              )
              .toList();
      final lastTimeUpdated = DateTime.now();
      emit(CartsLoadedState(carts, lastTimeUpdated));
    } catch (e) {
      print(e);
      emit(CartsLoadErrorState(isConnectionError: e is DioException));
    }
  }

  @override
  LoadCartsState? fromJson(Map<String, dynamic> json) {
    try {
      final carts =
          (json['carts'] as List)
              .map(
                (e) => Cart.fromJson(e),
              )
              .toList();
      final lastTimeUpdated = DateTimeUtils.fromBRLFormat(
        json['lastTimeUpdated'],
      );
      return CartsLoadedState(carts, lastTimeUpdated);
    } catch (_) {
      return InitialLoadCartsState();
    }
  }

  @override
  Map<String, dynamic>? toJson(LoadCartsState state) {
    if (state is CartsLoadedState) {
      return {
        'carts':
            state.carts
                .map((e) => e.toJson())
                .toList(),
        'lastTimeUpdated': DateTimeUtils.dateToBRLFormat(state.lastTimeUpdated),
      };
    }
    return null;
  }
}
