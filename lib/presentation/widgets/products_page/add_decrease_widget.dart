import 'package:flutter/material.dart';
import 'package:sell_point/core/constants/colors.dart';

class AddDecreaseWidget extends StatefulWidget {
  final void Function(int) onChange;
  final int quantity;

  const AddDecreaseWidget({
    super.key,
    required this.onChange,
    required this.quantity,
  });

  @override
  State<AddDecreaseWidget> createState() => _AddDecreaseWidgetState();
}

class _AddDecreaseWidgetState extends State<AddDecreaseWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.subtitleLightGray.withAlpha(150),
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.quantity > 0)
            GestureDetector(
              onTap: () {
                widget.onChange(widget.quantity-1);
              },
              child: Icon(Icons.remove, color: AppColors.subtitleLightGray),
            ),
          if (widget.quantity > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                widget.quantity.toString(),
                style: TextStyle(color: AppColors.subtitleGray.withAlpha(200)),
              ),
            ),
          GestureDetector(
            onTap: () {
              widget.onChange(widget.quantity+1);
            },
            child: Icon(Icons.add, color: AppColors.subtitleLightGray),
          ),
        ],
      ),
    );
  }
}
