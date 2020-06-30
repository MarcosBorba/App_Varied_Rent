import 'package:flutter/material.dart';
import 'package:varied_rent/utils/app_colors.dart';

class MyAccountPageMenuListTiles extends StatelessWidget {
  final Text title;
  final Function onTap;
  final IconData icon;
  final Color iconColor;
  final Color borderRightColor;

  const MyAccountPageMenuListTiles({
    Key key,
    this.title,
    this.onTap,
    this.iconColor = AppColors.iconColorOptionDefaultOfModalBottomSheet,
    this.borderRightColor =
        AppColors.iconColorOptionBorderRightOfModalBottomSheet,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
          padding: EdgeInsets.only(right: 18.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 0.5, color: borderRightColor))),
          child: Icon(icon, color: iconColor),
        ),
        title: title,
        onTap: onTap);
  }
}
