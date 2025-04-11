import 'package:flutter/material.dart';
import 'package:sell_point/core/routes.dart';
import 'package:sell_point/presentation/themes/light_theme.dart';
import 'package:sell_point/presentation/widgets/shared/global_alerts_handler.dart';

class SellPointApp extends StatelessWidget {
  const SellPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: Routes.seller,
      builder: (context, child) => GlobalAlertsHandler(child: child),
    );
  }
}
