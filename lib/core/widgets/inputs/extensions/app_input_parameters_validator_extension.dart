import 'package:flutter/services.dart';
import 'package:samay_test/core/widgets/inputs/src/text_field/app_input_parameters.dart';

extension AppInputParametersValidationExtension on AppInputParameters {
  List<TextInputFormatter> get textInputFormatter {
    late final TextInputFormatter inputFormatter;
    switch (inputType) {
      case AppInputType.alphabet:
        final alphabetRegex = RegExp(r"^[a-zA-Z\s]+$");
        inputFormatter = FilteringTextInputFormatter.allow(alphabetRegex);
        break;
      case AppInputType.number:
      case AppInputType.phone:
        inputFormatter = FilteringTextInputFormatter.digitsOnly;
        break;
      default:
        inputFormatter = FilteringTextInputFormatter.singleLineFormatter;
        break;
    }

    return [...?inputFormatters, inputFormatter];
  }

  String? inputValidator(String? data) {
    final value = data ?? '';
    if (value.isEmpty) {
      if (!isRequired) {
        return null;
      }

      return requiredErrorMessage;
    }

    if (customValidator != null) {
      final result = customValidator?.call(data, inputType);
      if (result != null) {
        return result;
      }
    }

    if (validator != null) {
      return validator?.call(data);
    }

    return null;
  }
}
