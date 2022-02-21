import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:varied_rent/utils/utils.dart';

//TODO: nivel 2 - criar components padrao para toda a aplicacao
class TextFieldDefaultAplication extends StatelessWidget {
  final TextEditingController inputController;
  final String labelText;
  final String hintText;
  final String helperText;
  final FormFieldValidator<String> validator;
  final bool obscureText;
  final bool filled;
  final bool autofocus;
  final IconData prefixIcon;
  final IconButton suffixIcon;
  final EdgeInsetsGeometry contentPadding;
  final Color cursorColor;
  final Color hintTextColor;
  final Color prefixIconColor;
  final Color labelTextColor;
  final Color defaultFormColor;
  final Color focusedDefaultFormColor;
  final Color fillColor;
  final TextInputType keyboardType;
  final Function onChanged;
  final Function onFieldSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final int maxLines;
  final double borderWidth;

  TextFieldDefaultAplication({
    Key key,
    this.inputController,
    this.labelText,
    this.validator,
    this.hintText,
    this.obscureText = false,
    this.prefixIcon,
    this.helperText,
    this.suffixIcon,
    this.contentPadding,
    this.cursorColor = AppColors.cursorTextFieldDefault,
    this.hintTextColor = AppColors.hintTextTextFieldDefault,
    this.prefixIconColor = AppColors.prefixIconTextFieldDefault,
    this.labelTextColor = AppColors.labelTextTextFieldDefault,
    this.defaultFormColor = AppColors.defaultFormBorderTextFieldDefault,
    this.focusedDefaultFormColor =
        AppColors.focusedDefaultFormBorderTextFieldDefault,
    this.keyboardType,
    this.onChanged,
    this.inputFormatters,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.filled = true,
    this.autofocus = false,
    this.fillColor = AppColors.fillColorBorderSearchTextField,
    this.maxLines,
    this.borderWidth,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    verifyPrefixIcon() {
      var turnBack;
      prefixIcon == null
          ? turnBack = null
          : turnBack = Icon(
              prefixIcon,
              color: prefixIconColor,
            );
      return turnBack;
    }

    borderDefault(Color color) {
      return OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: borderWidth == null ? AppSizes.size4 : borderWidth,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.size30),
        ),
      );
    }

    return TextFormField(
      decoration: InputDecoration(
        filled: filled,
        fillColor: fillColor,
        contentPadding: contentPadding,
        hintText: hintText,
        prefixIcon: verifyPrefixIcon(),
        labelStyle: TextStyle(color: labelTextColor),
        alignLabelWithHint: true,
        labelText: labelText,
        helperText: helperText,
        errorMaxLines: AppSizes.size2.toInt(),
        helperMaxLines: AppSizes.size2.toInt(),
        hintStyle: TextStyle(
          color: hintTextColor,
        ),
        enabledBorder: borderDefault(defaultFormColor),
        focusedBorder: borderDefault(focusedDefaultFormColor),
        errorBorder: borderDefault(defaultFormColor),
        focusedErrorBorder: borderDefault(focusedDefaultFormColor),
        suffixIcon: suffixIcon,
      ),
      focusNode: focusNode,
      autofocus: autofocus,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      cursorColor: cursorColor,
      controller: inputController,
      validator: validator,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      onTap: () {
        print("ontap");
        focusNode.requestFocus();
      },
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
    );
  }
}
