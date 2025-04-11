import 'package:flutter/material.dart';
import 'package:sell_point/core/constants/colors.dart';
import 'package:sell_point/core/constants/sizes.dart';
import 'package:sell_point/domain/product/product.dart';
import 'package:sell_point/domain/user/user.dart';
import 'package:sell_point/presentation/widgets/shared/button_widget.dart';
import 'package:sell_point/presentation/widgets/shared/product_widget.dart';
import '../../core/routes.dart';

class CartResumePage extends StatelessWidget {
  final Map<int, int> productQuantityMapping;
  final List<Product> products;
  final User user;

  const CartResumePage({
    super.key,
    required this.productQuantityMapping,
    required this.products,
    required this.user,
  });

  double get total {
    var totalValue = 0.0;
    for (var entry in productQuantityMapping.entries) {
      final product = products.firstWhere((p) => p.id == entry.key);
      totalValue += product.price * entry.value;
    }
    return totalValue;
  }

  double get totalValue {
    double totalValue = 0.0;
    for (var entry in productQuantityMapping.entries) {
      final product = products.firstWhere((p) => p.id == entry.key);
      totalValue += product.price * entry.value;
    }
    return totalValue;
  }

  void onFinish(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Selecione a forma de pagamento'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.payment,
                  arguments: {
                    'total': total,
                    'productQuantities': productQuantityMapping,
                    'user': user,
                  },
                );
              },
              child: const Text('Dinheiro'),
            ),
            SimpleDialogOption(onPressed: () {}, child: const Text('Pix')),
            SimpleDialogOption(
              onPressed: () {},
              child: const Text('Cartão de Crédito'),
            ),
            SimpleDialogOption(
              onPressed: () {},
              child: const Text('Cartão de Débito'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resumo do Carrinho',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.main,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.defaultHorizontalPadding,
                vertical: Sizes.defaultVerticalPadding,
              ),
              child: ListView.builder(
                itemCount: productQuantityMapping.length,
                itemBuilder: (context, index) {
                  final productId = productQuantityMapping.keys.elementAt(
                    index,
                  );
                  final product = products.firstWhere((p) => p.id == productId);
                  final quantity = productQuantityMapping[productId] ?? 0;
                  return ProductWidget(
                    product: product,
                    quantity: quantity,
                    readOnly: true,
                  );
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.defaultHorizontalPadding,
              vertical: Sizes.defaultVerticalPadding,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(30),
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'Total: R\$ ${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ButtonWidget(
                  title: 'Finalizar Compra',
                  onPress: () => onFinish(context),
                  height: 42,
                  leftIcon: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
