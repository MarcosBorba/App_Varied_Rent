import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:varied_rent/utils/app_colors.dart';
import 'package:varied_rent/utils/app_sizes.dart';

class BottomNavigationBarDefault extends StatelessWidget {
  final Color barBackgroundColor;
  final Color selectedItemBorderColor;
  final Color selectedItemBackgroundColor;
  final Color selectedItemIconColor;
  final Color selectedItemLabelColor;
  final Color unselectedItemIconColor;
  final Color unselectedItemLabelColor;
  final bool showSelectedItemShadow;
  final double itemWidth;
  final double barHeight;
  final List<FFNavigationBarItem> bottomNavigationBarItems;
  final Function onSelectTabItem;
  final int selectedIndex;

  const BottomNavigationBarDefault({
    Key key,
    this.bottomNavigationBarItems,
    this.onSelectTabItem,
    this.barBackgroundColor = AppColors.backgroundBottomNavigationBarDefault,
    this.selectedIndex = 0,
    this.showSelectedItemShadow = true,
    this.selectedItemBorderColor =
        AppColors.selectedItemBorderBottomNavigationBarDefault,
    this.selectedItemBackgroundColor =
        AppColors.selectedItemBackgroundBottomNavigationBarDefault,
    this.selectedItemIconColor =
        AppColors.selectedItemIconBottomNavigationBarDefault,
    this.selectedItemLabelColor =
        AppColors.selectedItemLabelBottomNavigationBarDefault,
    this.unselectedItemIconColor =
        AppColors.unSelectedItemIconBottomNavigationBarDefault,
    this.unselectedItemLabelColor =
        AppColors.unSelectedItemLabelBottomNavigationBarDefault,
    this.itemWidth,
    this.barHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FFNavigationBar(
      theme: FFNavigationBarTheme(
        barBackgroundColor: barBackgroundColor,
        selectedItemBorderColor: selectedItemBorderColor,
        selectedItemBackgroundColor: selectedItemBackgroundColor,
        selectedItemIconColor: selectedItemIconColor,
        selectedItemLabelColor: selectedItemLabelColor,
        unselectedItemIconColor: unselectedItemIconColor,
        unselectedItemLabelColor: unselectedItemLabelColor,
        showSelectedItemShadow: showSelectedItemShadow,
        itemWidth: itemWidth == null ? AppSizes.size50 : itemWidth,
        barHeight: barHeight == null ? AppSizes.size60 : barHeight,
      ),
      selectedIndex: selectedIndex,
      onSelectTab: onSelectTabItem,
      items: bottomNavigationBarItems,
    );
  }
}
