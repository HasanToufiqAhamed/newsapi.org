import 'package:flutter/material.dart';
import 'package:untitled/app/data/config/app_dimens.dart';
import 'package:untitled/app/utilities/extensions/widget.extensions.dart';

class SearchTextFormField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  ValueChanged<String>? onFieldSubmitted;
  Widget? suffixIcon;
  Function()? onTapSuffix;

  SearchTextFormField({
    Key? key,
    this.title,
    this.hintText,
    this.controller,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.onTapSuffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onFieldSubmitted: (v) {
        onFieldSubmitted?.call(v);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black.withOpacity(0.05),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
          borderRadius: 20.circularRadius,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
          borderRadius: 20.circularRadius,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
          borderRadius: 20.circularRadius,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
          borderRadius: 20.circularRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
          borderRadius: 20.circularRadius,
        ),
        suffixIcon: suffixIcon == null
            ? null
            : Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(onPressed: onTapSuffix, icon: suffixIcon!),
            ),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 20, right: 22),
          child: Icon(
            Icons.search_rounded,
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}
