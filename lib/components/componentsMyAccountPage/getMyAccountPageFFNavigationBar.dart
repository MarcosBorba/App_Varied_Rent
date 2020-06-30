import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:varied_rent/utils/app_colors.dart';
import 'package:varied_rent/utils/app_sizes.dart';

class MyAccountPageFFNavigationBar extends StatelessWidget {
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
  final List<FFNavigationBarItem> bottomNavyBarItems;
  final Function onSelectTab;
  final int selectedIndex;

  const MyAccountPageFFNavigationBar({
    Key key,
    this.bottomNavyBarItems,
    this.onSelectTab,
    this.barBackgroundColor = AppColors.backgroundColorBottomNanigationBar,
    this.selectedIndex = 0,
    this.showSelectedItemShadow = true,
    this.selectedItemBorderColor =
        AppColors.selectedItemBorderColorBottomNanigationBar,
    this.selectedItemBackgroundColor =
        AppColors.selectedItemBackgroundColorBottomNanigationBar,
    this.selectedItemIconColor =
        AppColors.selectedItemIconColorBottomNanigationBar,
    this.selectedItemLabelColor =
        AppColors.selectedItemLabelColorBottomNanigationBar,
    this.unselectedItemIconColor =
        AppColors.unselectedItemIconColorBottomNanigationBar,
    this.unselectedItemLabelColor =
        AppColors.unselectedItemLabelColorBottomNanigationBar,
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
      onSelectTab: onSelectTab,
      items: bottomNavyBarItems,
    );
  }
}
