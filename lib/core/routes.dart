import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/core/bindings.dart';
import 'package:sell_point/domain/product/product.dart';
import 'package:sell_point/domain/user/user.dart';
import 'package:sell_point/logic/cubits/cart/action/action_cart_cubit.dart';
import 'package:sell_point/logic/cubits/cart/flow/cart_flow_cubit.dart';
import 'package:sell_point/logic/cubits/global_alert/global_alert_cubit.dart';
import 'package:sell_point/logic/cubits/product/load/load_products_cubit.dart';
import 'package:sell_point/logic/cubits/user/load/load_users_cubit.dart';
import 'package:sell_point/presentation/pages/cart_resume_page.dart';
import 'package:sell_point/presentation/pages/payment_page.dart';
import 'package:sell_point/presentation/pages/products_page.dart';
import 'package:sell_point/presentation/pages/sellers_page.dart';

abstract class Routes {
  static const products = '/products';
  static const seller = '/seller';
  static const sellResume = '/sell-resume';
  static const payment = '/payment';
  static const admin = '/admin';
  static const insertProductOnCartPage = '/insert-product-on-cart';
  static const cartResume = '/cart-resume';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case products:
        final user = settings.arguments as User;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<LoadProductsCubit>.value(value: Bindings.get()),
                BlocProvider<GlobalAlertCubit>.value(value: Bindings.get()),
                BlocProvider<CartFlowCubit>.value(value: Bindings.get()),
              ],
              child: ProductsPage(user: user),
            );
          },
        );
      case seller:
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<LoadProductsCubit>.value(value: Bindings.get()),
                BlocProvider<LoadUsersCubit>.value(value: Bindings.get()),
              ],
              child: SellersPage(),
            );
          },
        );
      case cartResume:
        return MaterialPageRoute(
          builder: (context) {
            final args = settings.arguments as Map;
            final productQuantityMapping =
                args['productQuantityMapping'] as Map<int, int>;
            final user = args['user'] as User;
            final products = args['products'] as List<Product>;
            return CartResumePage(
              products: products,
              productQuantityMapping: productQuantityMapping,
              user: user,
            );
          },
        );
      case payment:
        return MaterialPageRoute(
          builder: (context) {
            final args = settings.arguments as Map;
            final productQuantityMapping =
                args['productQuantities'] as Map<int, int>;
            final user = args['user'] as User;
            final total = args['total'] as double;
            return MultiBlocProvider(
              providers: [
                BlocProvider<ActionCartCubit>.value(value: Bindings.get()),
                BlocProvider<CartFlowCubit>.value(value: Bindings.get()),
                BlocProvider<GlobalAlertCubit>.value(value: Bindings.get()),
              ],
              child: PaymentPage(
                total: total,
                productQuantities: productQuantityMapping,
                user: user,
              ),
            );
          },
        );
    }
    return null;
  }
}
