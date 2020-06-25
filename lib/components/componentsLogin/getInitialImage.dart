import 'package:flutter/material.dart';
import 'package:varied_rent/utils/app_colors.dart';
import 'package:varied_rent/utils/app_sizes.dart';

class InitialImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: AppSizes.size4,
      type: MaterialType.circle,
      clipBehavior: Clip.hardEdge,
      color: AppColors().backgroundImage,
      child: Image.network(
        'https://cdn.pixabay.com/photo/2020/05/10/03/48/paragliding-5152195_960_720.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
