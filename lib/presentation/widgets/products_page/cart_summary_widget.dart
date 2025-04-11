import 'package:flutter/material.dart';
import 'package:sell_point/core/constants/colors.dart';
import 'package:sell_point/domain/product/product.dart';
import 'package:sell_point/presentation/widgets/shared/button_widget.dart';

class CartSummaryDTO {
  final Product product;
  final int quantity;

  CartSummaryDTO({required this.product, required this.quantity});
}

class CartSummaryWidget extends StatelessWidget {
  final List<CartSummaryDTO> summary;
  final VoidCallback aoContinuar;

  const CartSummaryWidget({
    super.key,
    required this.summary,
    required this.aoContinuar,
  });

  double get total =>
      summary.fold(0, (sum, s) => sum + (s.product.price * s.quantity));

  int get totalItems => summary.fold(0, (sum, s) => sum + s.quantity);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      child: Row(
        children: [
          Expanded(
            child: Text(
              'R\$ ${total.toStringAsFixed(2)} • $totalItems itens',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          ButtonWidget(
            onPress: aoContinuar,
            title: 'Continuar',
            height: 41,
            color: AppColors.accentGreen,
          ),
        ],
      ),
    );
  }
}
