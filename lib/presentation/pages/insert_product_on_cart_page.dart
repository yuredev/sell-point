import 'package:flutter/material.dart';
import 'package:sell_point/core/constants/colors.dart';

class InsertProductOnCartPage extends StatelessWidget {
  final int cartId;

  const InsertProductOnCartPage({super.key, required this.cartId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos', style: TextStyle(color: Colors.white)),
        backgroundColor: SellPointColors.main,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: SellPointColors.accentGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
