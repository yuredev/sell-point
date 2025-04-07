import 'package:flutter/material.dart';
import 'package:sell_point/domain/product/product.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
      leading: const Icon(Icons.shopping_cart_outlined),
    );
  }
}
