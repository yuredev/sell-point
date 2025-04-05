import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/core/bindings.dart';
import 'package:sell_point/logic/cubits/products/load/load_products_cubit.dart';
import 'package:sell_point/presentation/pages/products_page.dart';

abstract class Routes {
  static const products = '/products';
  static const sellResume = '/sell-resume';
  static const payment = '/payment';
  static const admin = '/admin';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case products:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<LoadProductsCubit>.value(
              value: Bindings.get(),
              child: ProductsPage(),
            );
          },
        );
      // case admin:
      //   return
    }
    return null;
  }
}
