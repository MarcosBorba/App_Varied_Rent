import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/utils/utils.dart';

class EditMyProfilePageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditMyProfilePageFormState();
}

//TODO: nivel 4 - definir texts, colors, routes, aplicar as mascaras
class EditMyProfilePageFormState extends State<EditMyProfilePageForm> {
  String selectedItemOfGenderType;
  String selectedItemOfLandlordType;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _cpfCnpjController = new TextEditingController();
  TextEditingController _telephoneMandatoryController =
      new TextEditingController();
  TextEditingController _telephoneOptionalController =
      new TextEditingController();
  final GlobalKey<FormState> _keyFormEditMyProfile = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<EditMyProfileBloc, EditMyProfileState>(
        listener: (context, state) {
          if (state is EditProfileInitialData) {
            _nameController.text = state.name;
            _cpfCnpjController.text = state.cpfCnpj;
            _telephoneMandatoryController.text = state.phones.telephone1;
            _telephoneOptionalController.text = state.phones.telephone2;
            //selectedItemOfGenderType = state.genre;
            //selectedItemOfLandlordType = state.landlordType;
            print("print datas => " + state.toString());
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
