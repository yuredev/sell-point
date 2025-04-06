import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sell_point/app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sell_point/core/bindings.dart';
import 'package:sell_point/logic/cubits/cart/load/load_carts_cubit.dart';
import 'package:sell_point/logic/cubits/cart/load/load_carts_state.dart';
import 'package:sell_point/logic/cubits/product/load/load_products_cubit.dart';
import 'package:sell_point/logic/cubits/user/load/load_users_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final path = (await getApplicationDocumentsDirectory()).path;
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(path),
  );

  Bindings.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final loadProductsCubit = Bindings.get<LoadProductsCubit>();
  final loadUsersCubit = Bindings.get<LoadUsersCubit>();
  final loadCartsCubit = Bindings.get<LoadCartsCubit>();

  if (loadUsersCubit.shouldRefresh ||
      loadProductsCubit.shouldRefresh ||
      loadCartsCubit.state is! CartsLoadedState) {
    loadProductsCubit
        .load()
        .then((_) => loadUsersCubit.load())
        .then((_) => loadCartsCubit.load());
  }
  runApp(SellPointApp());
}
