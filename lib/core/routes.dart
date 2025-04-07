import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/core/bindings.dart';
import 'package:sell_point/domain/cart/cart.dart';
import 'package:sell_point/logic/cubits/cart/load/load_carts_cubit.dart';
import 'package:sell_point/logic/cubits/product/load/load_products_cubit.dart';
import 'package:sell_point/logic/cubits/product/search/search_product_cubit.dart';
import 'package:sell_point/logic/cubits/user/load/load_users_cubit.dart';
import 'package:sell_point/presentation/pages/insert_product_on_cart_page.dart';
import 'package:sell_point/presentation/pages/products_page.dart';
import 'package:sell_point/presentation/pages/seller_page.dart';

abstract class Routes {
  static const products = '/products';
  static const seller = '/seller';
  static const sellResume = '/sell-resume';
  static const payment = '/payment';
  static const admin = '/admin';
  static const insertProductOnCartPage = '/insert-product-on-cart';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case products:
        final cart = settings.arguments as Cart;
        return MaterialPageRoute(
          builder: (context) {
            return ProductsPage(cart: cart);
          },
        );
      case seller:
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<LoadProductsCubit>.value(value: Bindings.get()),
                BlocProvider<LoadCartsCubit>.value(value: Bindings.get()),
                BlocProvider<LoadUsersCubit>.value(value: Bindings.get()),
              ],
              child: SellerPage(),
            );
          },
        );
      case insertProductOnCartPage:
        final cartId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<SearchProductCubit>.value(
              value: Bindings.get(),
              child: InsertProductOnCartPage(cartId: cartId),
            );
          },
        );
    }
    return null;
  }
}
