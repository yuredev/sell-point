import 'package:flutter/material.dart';
import 'package:sell_point/domain/cart/cart.dart';
import 'package:sell_point/presentation/components/shared/gray_bar_widget.dart';
import 'package:sell_point/presentation/components/shared/shimmer_widget.dart';
import 'package:sell_point/utils/string_utils.dart';

class UserItemOfListWidget extends StatelessWidget {
  final Cart? cart;
  final VoidCallback? onTap;
  final bool isLoading;

  const UserItemOfListWidget({
    super.key,
    this.cart,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = ListTile(
      title:
          isLoading
              ? GrayBarWidget(
                height: 25,
                width: 40,
                padding: EdgeInsets.symmetric(vertical: 5),
              )
              : Text(StringUtils.toPersonalName(cart!.user.username)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLoading
              ? GrayBarWidget(
                height: 20,
                width: 140,
                padding: EdgeInsets.symmetric(vertical: 5),
              )
              : Text('${cart!.products.length} produtos vendidos'),
          isLoading
              ? GrayBarWidget(
                height: 20,
                width: 70,
                padding: EdgeInsets.symmetric(vertical: 5),
              )
              : Text(
                'R\$ ${cart!.products.fold<double>(0, (total, p) => total + p.price).toStringAsFixed(2)}',
              ),
        ],
      ),
      leading: const Icon(Icons.person_rounded, size: 36, color: Colors.grey),
      onTap: onTap,
      enableFeedback: false,
    );
    return Card(
      elevation: 1,
      color: Colors.white,
      child: isLoading ? ShimmerWidget(child: content) : content,
    );
  }
}
