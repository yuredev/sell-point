import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sell_point/core/constants/urls.dart';
import 'package:sell_point/logic/cubits/cart/action/action_cart_cubit.dart';
import 'package:sell_point/logic/cubits/cart/flow/cart_flow_cubit.dart';
import 'package:sell_point/logic/cubits/global_alert/global_alert_cubit.dart';
import 'package:sell_point/logic/cubits/product/load/load_products_cubit.dart';
import 'package:sell_point/logic/cubits/user/load/load_users_cubit.dart';
import 'package:sell_point/repository/cart/cart_repository.dart';
import 'package:sell_point/repository/product/product_repository.dart';
import 'package:sell_point/repository/user/user_repository.dart';

abstract class Bindings {
  static T get<T extends Object>({String? instanceName}) {
    return GetIt.I.get<T>(instanceName: instanceName);
  }

  static void set<T extends Object>(T object, {String? instanceName}) {
    GetIt.I.registerLazySingleton<T>(() => object, instanceName: instanceName);
  }

  static void init() {
    final dio = Dio();
    set(ProductRepository(dio, URLs.fakeStoreAPI));
    set(CartRepository(dio, URLs.fakeStoreAPI));
    set(UserRepository(dio, URLs.fakeStoreAPI));
    set(GlobalAlertCubit());
    set(LoadUsersCubit(userRepository: get()));
    set(LoadProductsCubit(productRepository: get()));
    set(CartFlowCubit());
    set(ActionCartCubit(cartRepository: get(), cartFlowCubit: get()));
  }
}
