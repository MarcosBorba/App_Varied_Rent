import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/editAdsPages/editAdsForm.dart';

class EditAdsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditAdsPageState();
}

class EditAdsPageState extends State<EditAdsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: AppColors.insertAdStatusBar,
          ),
          child: EditAdsForm()),
    );
  }
}
