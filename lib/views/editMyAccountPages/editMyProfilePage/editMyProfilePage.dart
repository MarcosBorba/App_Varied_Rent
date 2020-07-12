import 'package:flutter/material.dart';
import 'package:varied_rent/utils/utils.dart';

class EditMyProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditMyProfilePageState();
}

class EditMyProfilePageState extends State<EditMyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: AppColors.tertiaryColor,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Container(
                decoration: boxDecoration(),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: screenHeight * 0.10,
                    ),
                    returnsALineWithAnIconAndATextForTheTitle(),
                    SizedBox(
                      height: screenHeight * 0.10,
                    ),
                    Divider(
                      endIndent: AppSizes.size10,
                      indent: AppSizes.size10,
                      thickness: AppSizes.size2,
                    ),
                    SizedBox(
                      height: screenHeight * 0.10,
                    ),
                    Form(
                      autovalidate: true,
                      child: Column(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        width: 2,
        color: AppColors.primaryColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(AppSizes.size40),
      ),
    );
  }

  Widget returnsALineWithAnIconAndATextForTheTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.mode_edit,
          size: AppSizes.size40,
          color: AppColors.editEmailOrPasswordColorIconTitle,
        ),
        Text(
          "   Edit Profile Data",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.editEmailOrPasswordColorTitle,
            fontSize: AppFontSize.s20,
          ),
        ),
      ],
    );
  }
}
