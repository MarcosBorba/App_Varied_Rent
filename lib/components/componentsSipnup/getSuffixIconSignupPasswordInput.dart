import 'package:flutter/material.dart';
import 'package:varied_rent/utils/app_colors.dart';

class SuffixIconSignupPasswordInput extends StatelessWidget {
  final bool obscurePassword;
  final Function onPressed;
  final Color color;

  const SuffixIconSignupPasswordInput(
      {Key key,
      this.onPressed,
      this.obscurePassword,
      this.color = AppColors.tertiaryColor})
      : super(key: key);
  @override
  IconButton build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon:
          obscurePassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
      color: color,
    );
  }
}
