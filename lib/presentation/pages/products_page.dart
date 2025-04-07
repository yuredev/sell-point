import 'package:flutter/material.dart';
import 'package:sell_point/core/constants/colors.dart';
import 'package:sell_point/core/constants/sizes.dart';
import 'package:sell_point/core/routes.dart';
import 'package:sell_point/domain/cart/cart.dart';
import 'package:sell_point/presentation/components/shared/product_widget.dart';

class ProductsPage extends StatelessWidget {
  final Cart cart;

  const ProductsPage({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Produtos da venda',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.main,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            Routes.insertProductOnCartPage,
            arguments: cart.id,
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: AppColors.accentGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.defaultHorizontalPadding,
          vertical: Sizes.defaultVerticalPadding,
        ),
        child: ListView.builder(
          itemCount: cart.products.length,
          itemBuilder: (context, index) {
            final product = cart.products[index];
            return Dismissible(
              key: Key(product.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Remover produto'),
                        content: const Text(
                          'Tem certeza que deseja remover este produto da venda?',
                        ),
                        actions: [
                          TextButton(
                            onPressed:
                                () => Navigator.of(context).pop(false),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed:
                                () => Navigator.of(context).pop(true),
                            child: const Text('Remover'),
                          ),
                        ],
                      ),
                );
              },
              onDismissed: (direction) {
                cart.products.removeAt(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.title} removido da venda'),
                  ),
                );
              },
              child: ProductWidget(product: product),
            );
          },
        ),
      ),
    );
  }
}
