import 'package:varied_rent/utils/app_texts.dart';

class FieldValidators {
  String emailFormFieldValidator(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return AppTexts().errorTextEmptyFieldOfEmailTextField;
    } else if (!regExp.hasMatch(value)) {
      return AppTexts().errorTextInvalidEmailOfEmailTextField;
    } else {
      return null;
    }
  }

  String passwordFormFieldValidator(String value) {
    String patttern = r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return AppTexts().errorTextEmptyFieldOfPasswordTextField;
    } else if (!regExp.hasMatch(value)) {
      return AppTexts().errorTextInvalidPasswordOfPasswordTextField;
    }
    return null;
  }

  String nameFormFieldValidator(String value) {
    String patttern =
        r'(^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð]{3,}(?: [a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð]{2,}){1,}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return AppTexts().errorTextEmptyFieldOfNameTextField;
    } else if (!regExp.hasMatch(value)) {
      return AppTexts().errorTextInvalidNameOfNameTextField;
    }
    return null;
  }

  String genderFormFieldValidator(value) {
    if (value == null) {
      return AppTexts().errorTextEmptyFieldOfGenderTextField;
    }
    return null;
  }

  String landlordTypeFormFieldValidator(value) {
    if (value == null) {
      return AppTexts().errorTextEmptyFieldOfLandlordTypesTextField;
    }
    return null;
  }

  String cpfCnpjFormFieldValidator(String value) {
    String patttern =
        r'(^([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})$)';
    RegExp regExp = new RegExp(patttern);
    if (value.toString().length == 0) {
      return AppTexts().errorTextEmptyFieldOfCpfCnpjTextField;
    } else if (!regExp.hasMatch(value.toString())) {
      return AppTexts().errorTextInvalidCpfCnpjOfCpfCnpjTextField;
    }
    return null;
  }

  String telephoneMandatoryFormFieldValidator(String value) {
    String patttern =
        r'(^[0-9]{2}\ ?(([6-9][0-9]{3}(\ ?|\-?)[0-9]{4})|(9[0-9]{4}(\ ?|\-?)[0-9]{4}))$)';
    RegExp regExp = new RegExp(patttern);
    if (value.toString().length == 0) {
      return AppTexts().errorTextEmptyFieldOfTelephoneMandatoryTextField;
    } else if (!regExp.hasMatch(value.toString())) {
      return AppTexts().errorTextInvalidTelephoneOfTelephoneMandatoryTextField;
    }
    return null;
  }

  String telephoneOptionalFormFieldValidator(String value) {
    String patttern =
        r'(^[0-9]{2}\ ?(([6-9][0-9]{3}(\ ?|\-?)[0-9]{4})|(9[0-9]{4}(\ ?|\-?)[0-9]{4}))$)';
    RegExp regExp = new RegExp(patttern);
    if (value.toString().length == 0) {
      return null;
    }else if (!regExp.hasMatch(value.toString())) {
      return AppTexts().errorTextInvalidTelephoneOfTelephoneMandatoryTextField;
    }
    return null;
  }

  String countryFormFieldValidator(String value) {
    if (value.length == 0) {
      return AppTexts().errorTextEmptyFieldOfCountryTextField;
    }
    return null;
  }

  String stateFormFieldValidator(String value) {
    if (value.length == 0) {
      return AppTexts().errorTextEmptyFieldOfStateTextField;
    }
    return null;
  }

  String cityFormFieldValidator(String value) {
    if (value.length == 0) {
      return AppTexts().errorTextEmptyFieldOfCityTextField;
    }
    return null;
  }

  String zipCodeFormFieldValidator(String value) {
    if (value.length == 0) {
      return AppTexts().errorTextEmptyFieldOfZipCodeTextField;
    }
    return null;
  }

  String neighborhoodFormFieldValidator(String value) {
    if (value.length == 0) {
      return AppTexts().errorTextEmptyFieldOfNeighborhoodTextField;
    }
    return null;
  }

  String streetFormFieldValidator(String value) {
    if (value.length == 0) {
      return AppTexts().errorTextEmptyFieldOfStreetTextField;
    }
    return null;
  }

  String numberFormFieldValidator(String value) {
    if (value.length == 0) {
      return AppTexts().errorTextEmptyFieldOfNumberTextField;
    }
    return null;
  }
}
