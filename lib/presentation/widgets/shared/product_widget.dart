import 'package:flutter/material.dart';
import 'package:sell_point/domain/product/product.dart';
import 'package:sell_point/presentation/widgets/products_page/add_decrease_widget.dart';
import 'package:sell_point/presentation/widgets/shared/gray_bar_widget.dart';
import 'package:sell_point/presentation/widgets/shared/shimmer_widget.dart';

class ProductWidget extends StatelessWidget {
  final void Function(int)? onChangeQuantity;
  final Product? product;
  final bool isLoading;
  final int quantity;
  final bool readOnly;

  const ProductWidget({
    super.key,
    this.product,
    this.readOnly = false,
    this.isLoading = false,
    this.onChangeQuantity,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final content = ListTile(
      title:
          isLoading
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GrayBarWidget(
                    height: 25,
                    width: 200,
                    padding: EdgeInsets.symmetric(vertical: 5),
                  ),
                  const GrayBarWidget(
                    height: 25,
                    width: 150,
                    padding: EdgeInsets.symmetric(vertical: 5),
                  ),
                ],
              )
              : Text(product!.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLoading
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GrayBarWidget(
                    height: 20,
                    width: 80,
                    padding: EdgeInsets.symmetric(vertical: 5),
                  ),
                ],
              )
              : Text('R\$ ${product!.price.toStringAsFixed(2)}'),
          if (readOnly)
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '${quantity.toString()}x',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            )
          else
            Align(
              alignment: Alignment.bottomRight,
              child:
                  onChangeQuantity == null
                      ? SizedBox(height: 25, width: 25)
                      : AddDecreaseWidget(
                        onChange: onChangeQuantity!,
                        quantity: quantity,
                      ),
            ),
        ],
      ),
      leading:
          isLoading
              ? GrayBarWidget(height: 50, width: 50)
              : Image.network(product!.image, width: 80, fit: BoxFit.contain),
    );

    return Card(
      elevation: 1,
      color: Colors.white,
      child: isLoading ? ShimmerWidget(child: content) : content,
    );
  }
}
