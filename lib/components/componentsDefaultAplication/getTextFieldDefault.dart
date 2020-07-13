import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:varied_rent/utils/utils.dart';

class TextFieldDefaultAplication extends StatelessWidget {
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
  final Color defaultFormColor;
  final Color focusedDefaultFormColor;
  final TextInputType keyboardType;
  final Function onChanged;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;
  final Function onFieldSubmitted;

  const TextFieldDefaultAplication(
      {Key key,
      this.inputController,
      this.labelText,
      this.validator,
      this.hintText,
      this.obscureText = false,
      this.prefixIcon,
      this.helperText,
      this.suffixIcon,
      this.contentPadding,
      this.cursorColor = AppColors.secondaryColor,
      this.hintTextColor = AppColors.secondaryColor,
      this.prefixIconColor = AppColors.tertiaryColor,
      this.labelTextColor = AppColors.tertiaryColor,
      this.defaultFormColor = AppColors.secondaryColor,
      this.focusedDefaultFormColor = AppColors.tertiaryColor,
      this.keyboardType,
      this.onChanged,
      this.inputFormatters,
      this.textInputAction,
      this.onFieldSubmitted})
      : super(key: key);
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
          width: AppSizes.size4,
        ),
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
        enabledBorder: borderDefault(defaultFormColor),
        focusedBorder: borderDefault(focusedDefaultFormColor),
        errorBorder: borderDefault(defaultFormColor),
        focusedErrorBorder: borderDefault(focusedDefaultFormColor),
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      cursorColor: cursorColor,
      controller: inputController,
      validator: validator,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
    );
  }
}
