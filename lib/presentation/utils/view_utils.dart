import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sell_point/core/constants/colors.dart';
import 'package:sell_point/presentation/widgets/shared/button_widget.dart';
import 'package:sell_point/presentation/widgets/shared/info_dialog_widget.dart';
import 'package:sell_point/presentation/widgets/shared/yes_not_dialog_widget.dart';

abstract class ViewUtils {
  static void showSnackBar(
    BuildContext context,
    String message, {
    bool isErrorMessage = false,
    bool shouldCloseCurrent = true,
  }) {
    const maxChars = 150;
    if (message.length > maxChars) {
      message = message.substring(0, maxChars - 1);
      message += '...';
    }
    if (shouldCloseCurrent) ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        backgroundColor: isErrorMessage ? Colors.red : AppColors.main,
      ),
    );
  }

  static void showToast(String text) async {
    await Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: text,
      backgroundColor: AppColors.toastGray,
      fontSize: 12,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static Future<bool?> showConfirmActionDialog(
    BuildContext context, {
    required String title,
    required String description,
    String confirmTitle = 'Confirmar',
    Color confirmColor = AppColors.lightBlue,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              const Icon(Icons.error, color: AppColors.alertYellow, size: 78),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Text(description, textAlign: TextAlign.center),
          ),
          titlePadding: EdgeInsets.symmetric(vertical: 18),
          actionsPadding: const EdgeInsets.symmetric(vertical: 18),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            ButtonWidget(
              title: 'Cancelar',
              color: AppColors.buttonGray,
              height: 46,
              fontSize: 16,
              onPress: () => Navigator.pop(context, false),
            ),
            ButtonWidget(
              title: confirmTitle,
              color: confirmColor,
              height: 46,
              fontSize: 16,
              onPress: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }

  static Future<bool?> showYesNotDialog(
    BuildContext context, {
    required String title,
    required String description,
    String? confirmText,
    String? cancelText,
    void Function()? onConfirm,
    String? confirmTitle,
    String? cancelTitle,
    Color? confirmColor = Colors.black,
    Color? cancelColor = Colors.black,
    Color? titleColor = Colors.black,
    bool isDismissable = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: isDismissable,
      builder: (BuildContext context) {
        return YesNotDialogWidget(
          context: context,
          title: title,
          description: description,
          cancelColor: cancelColor,
          confirmColor: confirmColor,
          onConfirm: onConfirm,
          titleColor: titleColor,
        );
      },
    );
  }

  static Future<void> showInfoDialog(
    BuildContext context, {
    required String text,
    required String imageName,
  }) async {
    await showDialog(
      context: context,
      builder: (ctx) => InfoDialogWidget(imageName: imageName, text: text),
    );
  }

  static Future<T?> showBottomModal<T>(BuildContext context, Widget widget) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      builder: (ctx) => widget,
    );
  }
}
