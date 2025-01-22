import 'package:get/get.dart';
import 'package:samay_test/core/widgets/inputs/src/text_field/app_input_parameters.dart';

class InputValidatorUtils {
  static String? validate(String? value, AppInputType inputType) {
    switch (inputType) {
      case AppInputType.textAndNumbers:
        final isValid = NewAppFieldsValidator.onlyTextAndNumbers(value ?? '');
        return isValid ? null : 'INVALID_TEXT_NUMBERS_INPUT'.tr;
      case AppInputType.email:
        final isValid = NewAppFieldsValidator.emailAddress(value ?? '');
        return isValid ? null : 'INVALID_EMAIL'.tr;
      case AppInputType.phone:
        final isValid = NewAppFieldsValidator.numberPhone(value ?? '');
        return isValid ? null : 'INVALID_PHONE_NUMBER'.tr;
      case AppInputType.password:
        final isValid = NewAppFieldsValidator.password(value ?? '');
        return isValid ? null : 'INVALID_PASSWORD'.tr;
      case AppInputType.alphabet:
        final isValid = NewAppFieldsValidator.onlyLetters(value ?? '');
        return isValid ? null : 'INVALID_TEXT_INPUT'.tr;

      default:
        return null;
    }
  }
}

mixin NewAppFieldsValidator {
  static bool password(String value, [int maxLengthPassword = 6]) {
    RegExp regExp1 = RegExp(r'^.{6,}$');
    return regExp1.hasMatch(value);
  }

  static bool numberPhone(String value) {
    RegExp regExp1 = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    return regExp1.hasMatch(value);
  }

  static bool emailAddress(String value) {
    final regExp1 = RegExp(
      r'^[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)*@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)*\.[a-zA-Z]{2,5}$',
    );

    return regExp1.hasMatch(value);
  }

  static bool onlyTextAndNumbers(String value) {
    RegExp regExp1 = RegExp(r'^[a-zA-ZÀ-ÿ0-9\s&]+$');
    return regExp1.hasMatch(value);
  }

  static bool onlyLetters(String value) {
    RegExp regExp1 = RegExp(r'^[a-zA-Z\s]+$');
    return regExp1.hasMatch(value);
  }

  static bool onlyTextNumbersAndEmailChars(String value) {
    RegExp regExp1 = RegExp(r'^[a-zA-ZÀ-ÿ0-9\s@.]+$');
    return regExp1.hasMatch(value);
  }

  static bool username(String value) {
    RegExp regExp1 = RegExp(r'^[a-zA-Z0-9._-]{3,30}$');
    return regExp1.hasMatch(value);
  }
}
