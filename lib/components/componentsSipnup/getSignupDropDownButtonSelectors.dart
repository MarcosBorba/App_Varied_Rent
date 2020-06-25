import 'package:flutter/material.dart';
import 'package:varied_rent/utils/app_colors.dart';
import 'package:varied_rent/utils/app_sizes.dart';

class SignupDropDownButtonSelectors extends StatelessWidget {
  final List<String> items;
  final Function onChanged;
  final String value;
  final String hint;
  final IconData suffixIcon;
  final IconData prefixIcon;
  final String helperText;
  final FormFieldValidator<String> validator;
  final Color focusedDefaultFormColor;
  final Color defaultFormColor;

  const SignupDropDownButtonSelectors({
    Key key,
    this.items,
    this.onChanged,
    this.value,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.helperText,
    this.validator,
    this.defaultFormColor = AppColors.secondaryColor,
    this.focusedDefaultFormColor = AppColors.tertiaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contentPadding = EdgeInsets.only(
      top: ((screenHeight * 0.65) * 0.20) * 0.19,
      bottom: ((screenHeight * 0.65) * 0.20) * 0.19,
      left: (screenWidth * 0.94) * 0.04,
      right: (screenWidth * 0.94) * 0.01,
    );
    borderDefault(Color color) {
      return OutlineInputBorder(
          borderSide: BorderSide(color: color, width: AppSizes.size4),
          borderRadius: BorderRadius.all(Radius.circular(AppSizes.size30)));
    }

    return DropdownButtonFormField<String>(
      items: items.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(dropDownStringItem),
        );
      }).toList(),
      onChanged: onChanged,
      value: value,
      validator: validator,
      hint: Text(
        hint,
        style: TextStyle(color: AppColors.tertiaryColor),
      ),
      icon: Icon(
        suffixIcon,
        color: AppColors.tertiaryColor,
      ),
      decoration: InputDecoration(
        helperText: helperText,
        contentPadding: contentPadding,
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.tertiaryColor,
        ),
        errorMaxLines: AppSizes.size2.toInt(),
        helperMaxLines: AppSizes.size2.toInt(),
        enabledBorder: borderDefault(defaultFormColor),
        focusedBorder: borderDefault(focusedDefaultFormColor),
        errorBorder: borderDefault(defaultFormColor),
        focusedErrorBorder: borderDefault(focusedDefaultFormColor),
      ),
    );
  }
}
