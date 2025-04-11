import 'package:flutter/material.dart';
import 'package:sell_point/domain/user/user.dart';
import 'package:sell_point/presentation/widgets/shared/gray_bar_widget.dart';
import 'package:sell_point/presentation/widgets/shared/shimmer_widget.dart';
import 'package:sell_point/utils/string_utils.dart';

class UserItemOfListWidget extends StatelessWidget {
  final User? user;
  final VoidCallback? onTap;
  final bool isLoading;

  const UserItemOfListWidget({
    super.key,
    this.user,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = ListTile(
      title:
          isLoading
              ? GrayBarWidget(
                height: 28,
                width: 40,
                padding: const EdgeInsets.symmetric(vertical: 5),
              )
              : Text(StringUtils.toPersonalName(user!.username)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLoading
              ? GrayBarWidget(
                height: 23,
                width: 140,
                padding: const EdgeInsets.symmetric(vertical: 5),
              )
              : Text(user!.email),
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
