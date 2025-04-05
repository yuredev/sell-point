import 'package:flutter/material.dart';
import 'package:sell_point/core/routes.dart';

class SellPointApp extends StatelessWidget {
  const SellPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: Routes.products,
    );
  }
}
