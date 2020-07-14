import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/utils/utils.dart';

class EditMyProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditMyProfilePageState();
}

//TODO: nivel 4 - definir texts, colors, routes, aplicar as mascaras
class EditMyProfilePageState extends State<EditMyProfilePage> {
  var selectedItemOfGenderType;
  var selectedItemOfLandlordType;
  TextEditingController _nameController;
  TextEditingController _cpfCnpjController;
  TextEditingController _telephoneMandatoryController;
  TextEditingController _telephoneOptionalController;
  final GlobalKey<FormState> _keyFormEditMyProfile = new GlobalKey();
  GlobalKey keyGender = new GlobalKey();

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
                      bottom: screenWidth * 0.04),
                  child: Column(
                    children: <Widget>[
                      returnsHeaderForm(),
                      returnMainFormEditProfile(),
                      Container(
                        height: screenHeight * 0.08,
                        width: screenWidth,
                        child: returnButtonSubmitForm(),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
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
          AppTexts().editMyProfileTitlePage,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.editEmailOrPasswordColorTitle,
            fontSize: AppFontSize.s20,
          ),
        ),
      ],
    );
  }

  Widget returnMainFormEditProfile() {
    return Form(
      autovalidate: true,
      key: _keyFormEditMyProfile,
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
          Container(
            height: screenHeight * 0.15,
            child: returnsCpfCnpjTextfield(),
          ),
          Container(
            height: screenHeight * 0.15,
            child: returnsTelephoneMandatoryTextfield(),
          ),
          Container(
            height: screenHeight * 0.15,
            child: returnsTelephoneOptionalTextfield(),
          ),
        ],
      ),
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
      inputController: _nameController,
      validator: FieldValidators().nameFormFieldValidator,
    );
  }

  Widget returnsGenderButtonSelector() {
    return DropDownButtonSelectorDefault(
      key: keyGender,
      prefixIcon: FontAwesome.venus_mars,
      suffixIcon: Icons.arrow_drop_down,
      hint: AppTexts().editMyProfileGenderSelectorHintText,
      helperText: AppTexts().editMyProfileGenderSelectordHelpText,
      items: AppTexts().editMyProfileGenderSelectorTypesList,
      value: selectedItemOfGenderType,
      validator: FieldValidators().genderFormFieldValidator,
    );
  }

  Widget returnsLandLordTypeButtonSelector() {
    return DropDownButtonSelectorDefault(
      prefixIcon: Icons.work,
      suffixIcon: Icons.arrow_drop_down,
      hint: AppTexts().editMyProfileLandlordSelectorHintText,
      helperText: AppTexts().editMyProfileLandlordSelectordHelpText,
      items: AppTexts().editMyProfileLandlordSelectorTypesList,
      value: selectedItemOfLandlordType,
      validator: FieldValidators().landlordTypeFormFieldValidator,
    );
  }

  Widget returnsCpfCnpjTextfield() {
    return TextFieldDefaultAplication(
      labelText: AppTexts().editMyProfileCpfCnpjTextFieldLabelText,
      hintText: AppTexts().editMyProfileCpfCnpjTextFieldHintText,
      helperText: AppTexts().editMyProfileCpfCnpjTextFieldHelpText,
      prefixIcon: FontAwesome5.id_badge,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      inputController: _cpfCnpjController,
      validator: FieldValidators().cpfCnpjFormFieldValidator,
      inputFormatters: [
        MaskedTextInputFormatterShifter(
            maskONE: "XXX.XXX.XXX-XX", maskTWO: "XX.XXX.XXX/XXXX-XX"),
      ],
    );
  }

  Widget returnsTelephoneMandatoryTextfield() {
    return TextFieldDefaultAplication(
      labelText: AppTexts().editMyProfileTelephoneMandatoryTextFieldLabelText,
      hintText: AppTexts().editMyProfileTelephoneMandatoryTextFieldHintText,
      helperText: AppTexts().editMyProfileTelephoneMandatoryTextFieldHelpText,
      prefixIcon: Icons.phone_android,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      inputController: _telephoneMandatoryController,
      validator: FieldValidators().telephoneMandatoryFormFieldValidator,
      inputFormatters: [
        MaskedTextInputFormatterShifter(
            maskONE: "XX XXXX-XXXX", maskTWO: "XX XXXXX-XXXX"),
      ],
    );
  }

  Widget returnsTelephoneOptionalTextfield() {
    return TextFieldDefaultAplication(
      labelText: AppTexts().editMyProfileTelephoneOptionalTextFieldLabelText,
      hintText: AppTexts().editMyProfileTelephoneOptionalTextFieldHintText,
      helperText: AppTexts().editMyProfileTelephoneOptionalTextFieldHelpText,
      prefixIcon: ModernPictograms.mobile,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      inputController: _telephoneOptionalController,
      validator: FieldValidators().telephoneOptionalFormFieldValidator,
      inputFormatters: [
        MaskedTextInputFormatterShifter(
            maskONE: "XX XXXX-XXXX", maskTWO: "XX XXXXX-XXXX"),
      ],
    );
  }

  Widget returnButtonSubmitForm() {
    return ButtonFormDefault(
      color: AppColors.tertiaryColor,
      textButton: AppTexts().editMyProfileConfirmSaveProfileData,
      onPressed: () {},
    );
  }
}
