import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/utils/utils.dart';

class EditMyProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditMyProfilePageState();
}

//TODO: nivel 4 - definir texts, colors, routes, validators
class EditMyProfilePageState extends State<EditMyProfilePage> {
  var select;
  final EdgeInsetsGeometry heightOfFieldsAccordingToContainerSize =
      EdgeInsets.symmetric(
          vertical: (screenHeight * 0.15) * 0.15,
          horizontal: (screenWidth * 0.90) * 0.02);
  final EdgeInsetsGeometry height =
      EdgeInsets.symmetric(vertical: (screenHeight * 0.15) * 0.15);

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
              padding: EdgeInsets.only(
                left: screenWidth * 0.03,
                right: screenWidth * 0.03,
              ),
              child: Container(
                decoration: boxDecoration(),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.02,
                    right: screenWidth * 0.02,
                  ),
                  child: Column(
                    children: <Widget>[
                      returnsHeaderForm(),
                      Form(
                        autovalidate: true,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: screenHeight * 0.15,
                              child: returnsNameTextfield(),
                            ),
                            Container(
                              height: screenHeight * 0.15,
                              child: returnsGenderButtonSelector(),
                            ),
                            Container(
                              height: screenHeight * 0.15,
                              child: returnsLandLordTypeButtonSelector(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
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
        width: screenWidth * 0.00500,
        color: AppColors.primaryColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(AppSizes.size40),
      ),
    );
  }

  Widget returnsHeaderForm() {
    return Column(
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
          height: screenHeight * 0.08,
        ),
      ],
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

  Widget returnsNameTextfield() {
    return TextFieldDefaultAplication(
      labelText: AppTexts().editMyProfileNameTextFieldLabelText,
      hintText: AppTexts().editMyProfileNameTextFieldHintText,
      helperText: AppTexts().editMyProfileNameTextFieldHelpText,
      prefixIcon: Icons.tag_faces,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  Widget returnsGenderButtonSelector() {
    return DropDownButtonSelectorDefault(
      prefixIcon: FontAwesome.venus_mars,
      suffixIcon: Icons.arrow_drop_down,
      hint: AppTexts().editMyProfileGenderSelectorHintText,
      helperText: AppTexts().editMyProfileGenderSelectordHelpText,
      items: AppTexts().editMyProfileGenderSelectorTypesList,
      value: select,
      onChanged: (value) {
        print(value);
      },
    );
  }

  Widget returnsLandLordTypeButtonSelector() {
    return DropDownButtonSelectorDefault(
      prefixIcon: Icons.work,
      suffixIcon: Icons.arrow_drop_down,
      hint: AppTexts().editMyProfileLandlordSelectorHintText,
      helperText: AppTexts().editMyProfileLandlordSelectordHelpText,
      items: AppTexts().editMyProfileLandlordSelectorTypesList,
      value: select,
      onChanged: (value) {
        print(value);
      },
    );
  }
}
