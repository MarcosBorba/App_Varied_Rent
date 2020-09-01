import 'package:flutter/material.dart';
import 'package:varied_rent/utils/app_colors.dart';
import 'package:varied_rent/utils/app_sizes.dart';

class HomePageSearchTextsField extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final IconData prefixIcon;
  final EdgeInsetsGeometry contentPadding;
  final Color cursorColor;
  final Color hintTextColor;
  final Color prefixIconColor;
  final Color defaultFormColorBorder;
  final Color focusedDefaultFormColorBorder;
  final TextInputType keyboardType;
  final Color fillColor;
  final bool filled;
  final bool autofocus;
  final Function onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Align textAlignVertical;

  const HomePageSearchTextsField(
      {Key key,
      this.inputController,
      this.hintText,
      this.prefixIcon,
      this.contentPadding,
      this.cursorColor = AppColors.cursorColorSearchTextField,
      this.hintTextColor = AppColors.hintTextColorSearchTextField,
      this.prefixIconColor = AppColors.prefixIconColorSearchTextField,
      this.defaultFormColorBorder =
          AppColors.defaultFormColorBorderSearchTextField,
      this.focusedDefaultFormColorBorder =
          AppColors.focusedDefaultFormColorBorderSearchTextField,
      this.keyboardType,
      this.fillColor = AppColors.fillColorBorderSearchTextField,
      this.filled = true,
      this.onSubmitted,
      this.autofocus = true,
      this.focusNode,
      this.textInputAction,
      this.textAlignVertical})
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
          width: AppSizes.size3,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.size30),
        ),
      );
    }

    return Container(
      alignment: AlignmentDirectional.center,
      height: AppSizes.size50,
      width: screenWidth * 0.90,
      child: TextField(
        decoration: InputDecoration(
          filled: filled,
          fillColor: fillColor,
          contentPadding: contentPadding == null
              ? EdgeInsets.symmetric(
                  horizontal: AppSizes.size10, vertical: AppSizes.size0)
              : contentPadding,
          hintText: hintText,
          prefixIcon: verifyPrefixIcon(),
          errorMaxLines: AppSizes.size2.toInt(),
          hintStyle: TextStyle(
            color: hintTextColor,
          ),
          enabledBorder: borderDefault(defaultFormColorBorder),
          focusedBorder: borderDefault(focusedDefaultFormColorBorder),
          errorBorder: borderDefault(defaultFormColorBorder),
          focusedErrorBorder: borderDefault(focusedDefaultFormColorBorder),
        ),
        keyboardType: keyboardType,
        cursorColor: cursorColor,
        controller: inputController,
        autofocus: autofocus,
        focusNode: focusNode,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
