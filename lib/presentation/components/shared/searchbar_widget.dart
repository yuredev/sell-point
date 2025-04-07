import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;
import 'package:sell_point/core/constants/colors.dart';

class SearchBarWidget extends StatefulWidget {
  final String? label;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final void Function()? onSendButtonPressed;
  final Color? sendButtonColor;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final GlobalKey<FormState>? formKey;
  final List<TextInputFormatter>? inputFormatters;
  final bool capitalizeInput;
  final TextInputType? keyboardType;

  const SearchBarWidget({
    super.key,
    this.controller,
    this.formKey,
    this.capitalizeInput = false,
    this.onChanged,
    this.keyboardType,
    this.label,
    this.onSendButtonPressed,
    this.validator,
    this.onFieldSubmitted,
    this.textInputAction,
    this.sendButtonColor,
    this.inputFormatters,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: widget.validator,
        controller: widget.controller,
        onChanged: widget.onChanged,
        autocorrect: false,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        textCapitalization:
            widget.capitalizeInput
                ? TextCapitalization.sentences
                : TextCapitalization.none,
        style: const TextStyle(color: AppColors.textField),
        enableSuggestions: false,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon:
              widget.onSendButtonPressed != null
                  ? IconButton(
                    padding: const EdgeInsets.all(0),
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      if (widget.formKey == null ||
                          widget.formKey!.currentState!.validate()) {
                        widget.onSendButtonPressed!();
                      }
                    },
                    icon: Container(
                      height: 50,
                      width: 40,
                      decoration: BoxDecoration(
                        color:
                            widget.sendButtonColor ?? const Color(0xffd8d8d8),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(7),
                          bottomRight: Radius.circular(7),
                        ),
                      ),
                      child: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  )
                  : null,
          contentPadding: const EdgeInsets.only(
            left: 16.48,
            top: 15,
            bottom: 15,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.textFieldBackground),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: widget.label,
          fillColor: AppColors.textFieldBackground,
          filled: true,
        ),
      ),
    );
  }
}
