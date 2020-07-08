import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:varied_rent/utils/app_colors.dart';
import 'package:varied_rent/utils/app_sizes.dart';

class EditEmailTextsFields extends StatelessWidget {
  final TextEditingController inputController;
  final String labelText;
  final FormFieldValidator<String> validator;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;
  final IconButton suffixIcon;
  final String helperText;
  final EdgeInsetsGeometry contentPadding;
  final Color cursorColor;
  final Color hintTextColor;
  final Color prefixIconColor;
  final Color labelTextColor;
  final Color borderColor;
  final Color borderFocusedColor;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;
  final Function onFieldSubmitted;

  const EditEmailTextsFields({
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
    this.cursorColor = AppColors.editEmailColorCursorTextField,
    this.hintTextColor = AppColors.editEmailColorHintTextField,
    this.prefixIconColor = AppColors.editEmailColorPrefixIconTextField,
    this.labelTextColor = AppColors.editEmailColorLabelTextField,
    this.borderColor = AppColors.editEmailColorBorderTextField,
    this.borderFocusedColor = AppColors.editEmailColorBorderFocusedTextField,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    verifyPrefixIcon() {
      var turnBack;
      prefixIcon == null
          ? turnBack = null
          : turnBack = Icon(prefixIcon, color: prefixIconColor);
      return turnBack;
    }

    borderDefault(Color color) {
      return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: AppSizes.size4),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.size30),
        ),
      );
    }

    return TextFormField(
        decoration: InputDecoration(
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
          enabledBorder: borderDefault(borderColor),
          focusedBorder: borderDefault(borderFocusedColor),
          errorBorder: borderDefault(borderColor),
          focusedErrorBorder: borderDefault(borderFocusedColor),
          suffixIcon: suffixIcon,
        ),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText,
        cursorColor: cursorColor,
        controller: inputController,
        validator: validator,
        inputFormatters: inputFormatters);
  }
}
