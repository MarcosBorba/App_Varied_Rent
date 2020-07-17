import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:varied_rent/blocs/editAddressData_bloc/editAddressData_bloc.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';

class EditMyAddressPageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditMyAddressPageFormState();
}

class EditMyAddressPageFormState extends State<EditMyAddressPageForm> {
  TextEditingController _countryController = new TextEditingController();
  TextEditingController _stateController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _zipCodeController = new TextEditingController();
  TextEditingController _neighborhoodController = new TextEditingController();
  TextEditingController _streetController = new TextEditingController();
  TextEditingController _numberController = new TextEditingController();
  final GlobalKey<FormState> _keyFormEditMyAddress = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditMyAddressBloc, EditMyAddressState>(
      listener: (context, state) {
        if (state is EditAddressInitialData) {
          _countryController.text = state.country;
          _stateController.text = state.state;
          _cityController.text = state.city;
          _zipCodeController.text = state.zip_code;
          _neighborhoodController.text = state.neighborhood;
          _streetController.text = state.street;
          _numberController.text = state.number;
        } else if (state is DataAddressSuccessfullyEdited) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Entypo.check),
                    Text(
                      AppTexts.editMyProfileUpdateSuccessfully,
                    ),
                  ],
                ),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 5)),
          );
        }
      },
      child: BlocBuilder<EditMyAddressBloc, EditMyAddressState>(
        builder: (context, state) {
          return Form(
            key: _keyFormEditMyAddress,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                Container(
                  height: screenHeight * 0.15,
                  child: returnsCountryTextfield(),
                ),
                Container(
                    height: screenHeight * 0.15,
                    child: returnsStateTextfield()),
                Container(
                  height: screenHeight * 0.15,
                  child: returnsCityTextfield(),
                ),
                Container(
                  height: screenHeight * 0.15,
                  child: returnsZipCodeTextfield(),
                ),
                Container(
                  height: screenHeight * 0.15,
                  child: returnsNeighborhoodTextfield(),
                ),
                Container(
                  height: screenHeight * 0.15,
                  child: returnsStreetTextfield(),
                ),
                Container(
                  height: screenHeight * 0.15,
                  child: returnsNumberTextfield(),
                ),
                Container(
                  height: screenHeight * 0.08,
                  width: screenWidth,
                  child: state is LoadingAddressDataEditing
                      ? returnLinearProgressLoading(
                          screenHeight * 0.01, screenWidth)
                      : returnButtonSubmitForm(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget returnsCountryTextfield() {
    return TextFieldDefaultAplication(
      labelText: AppTexts().editMyProfileNameTextFieldLabelText,
      hintText: AppTexts().editMyProfileNameTextFieldHintText,
      helperText: AppTexts().editMyProfileNameTextFieldHelpText,
      prefixIcon: Icons.tag_faces,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      inputController: _countryController,
      validator: FieldValidators().countryFormFieldValidator,
    );
  }

  Widget returnsStateTextfield() {
    return TextFieldDefaultAplication(
      labelText: AppTexts().editMyProfileNameTextFieldLabelText,
      hintText: AppTexts().editMyProfileNameTextFieldHintText,
      helperText: AppTexts().editMyProfileNameTextFieldHelpText,
      prefixIcon: Icons.tag_faces,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      inputController: _stateController,
      validator: FieldValidators().stateFormFieldValidator,
    );
  }

  Widget returnsCityTextfield() {
    return TextFieldDefaultAplication(
      labelText: AppTexts().editMyProfileNameTextFieldLabelText,
      hintText: AppTexts().editMyProfileNameTextFieldHintText,
      helperText: AppTexts().editMyProfileNameTextFieldHelpText,
      prefixIcon: Icons.tag_faces,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      inputController: _cityController,
      validator: FieldValidators().cityFormFieldValidator,
    );
  }

  Widget returnsZipCodeTextfield() {
    return TextFieldDefaultAplication(
      labelText: AppTexts().editMyProfileNameTextFieldLabelText,
      hintText: AppTexts().editMyProfileNameTextFieldHintText,
      helperText: AppTexts().editMyProfileNameTextFieldHelpText,
      prefixIcon: Icons.tag_faces,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      inputController: _zipCodeController,
      validator: FieldValidators().zipCodeFormFieldValidator,
    );
  }

  Widget returnsNeighborhoodTextfield() {
    return TextFieldDefaultAplication(
      labelText: AppTexts().editMyProfileNameTextFieldLabelText,
      hintText: AppTexts().editMyProfileNameTextFieldHintText,
      helperText: AppTexts().editMyProfileNameTextFieldHelpText,
      prefixIcon: Icons.tag_faces,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      inputController: _neighborhoodController,
      validator: FieldValidators().neighborhoodFormFieldValidator,
    );
  }

  Widget returnsStreetTextfield() {
    return TextFieldDefaultAplication(
      labelText: AppTexts().editMyProfileNameTextFieldLabelText,
      hintText: AppTexts().editMyProfileNameTextFieldHintText,
      helperText: AppTexts().editMyProfileNameTextFieldHelpText,
      prefixIcon: Icons.tag_faces,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      inputController: _streetController,
      validator: FieldValidators().streetFormFieldValidator,
    );
  }

  Widget returnsNumberTextfield() {
    return TextFieldDefaultAplication(
      labelText: AppTexts().editMyProfileNameTextFieldLabelText,
      hintText: AppTexts().editMyProfileNameTextFieldHintText,
      helperText: AppTexts().editMyProfileNameTextFieldHelpText,
      prefixIcon: Icons.tag_faces,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      inputController: _numberController,
      validator: FieldValidators().numberFormFieldValidator,
    );
  }

  Widget returnButtonSubmitForm() {
    return ButtonFormDefault(
      color: AppColors.editMyProfileButtonSubmit,
      textButton: "Save Address Data",
      onPressed: onButtonSubmitFormPressed,
    );
  }

  onButtonSubmitFormPressed() {
    _keyFormEditMyAddress.currentState.validate()
        ? submitFormEditMyProfile()
        : false;
  }

  submitFormEditMyProfile() {
    BlocProvider.of<EditMyAddressBloc>(context).add(
      SaveAddressDataButtonPressed(
        user: new User(
          address: new Address(
            country: _countryController.text,
            state: _stateController.text,
            city: _cityController.text,
            zip_code: _zipCodeController.text,
            neighborhood: _neighborhoodController.text,
            street: _streetController.text,
            number: _numberController.text,
          ),
        ),
      ),
    );
  }

  Widget returnLinearProgressLoading(double height, double width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: height,
            width: width,
            child: returnsLinearProgressLoading(),
          ),
        ),
      ],
    );
  }

  Widget returnsLinearProgressLoading() {
    return LinearProgressIndicator(
      backgroundColor: AppColors.editMyProfileLinearProgressBackground,
      valueColor: AlwaysStoppedAnimation<Color>(
          AppColors.editMyProfileLinearProgressSecondary),
    );
  }
}
