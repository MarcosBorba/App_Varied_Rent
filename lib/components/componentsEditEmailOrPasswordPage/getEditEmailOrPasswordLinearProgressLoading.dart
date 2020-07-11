import 'package:flutter/material.dart';
import 'package:varied_rent/utils/utils.dart';

class EditEmailOrPasswordLinearProgressIndicator extends StatelessWidget {
  final double heightDisponibleProgressIndicator;
  final double widthDisponibleProgressIndicator;
  final double heightLinearProgressLoading;
  final double widthLinearProgressLoading;
  final Color colorProgressIndicatorBackground;
  final Color colorProgressIndicatorSecondary;

  const EditEmailOrPasswordLinearProgressIndicator({
    Key key,
    this.heightDisponibleProgressIndicator,
    this.widthDisponibleProgressIndicator,
    this.heightLinearProgressLoading,
    this.widthLinearProgressLoading,
    this.colorProgressIndicatorBackground =
        AppColors.editEmailOrPasswordColorProgressIndicatorBackground,
    this.colorProgressIndicatorSecondary =
        AppColors.editEmailOrPasswordColorProgressIndicatorSecondary,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightDisponibleProgressIndicator,
      width: widthDisponibleProgressIndicator,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          returnsARoundedLinearProgressLoading(
            heightLinearProgressLoading,
            widthLinearProgressLoading,
          ),
        ],
      ),
    );
  }

  Widget returnsARoundedLinearProgressLoading(
      double linearHeight, double linearWidth) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: linearHeight,
          width: linearWidth,
          child: returnsLinearProgressLoading(),
        ));
  }

  Widget returnsLinearProgressLoading() {
    return LinearProgressIndicator(
      backgroundColor: colorProgressIndicatorBackground,
      valueColor: AlwaysStoppedAnimation<Color>(
        colorProgressIndicatorSecondary,
      ),
    );
  }
}
