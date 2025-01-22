import 'package:flutter/material.dart';
import 'package:samay_test/core/widgets/inputs/src/text_field/app_input_parameters.dart';

extension AppInputParametersExtension on AppInputParameters {
  TextInputType get keyboardType {
    switch (inputType) {
      case AppInputType.number:
        return TextInputType.number;
      case AppInputType.phone:
        return TextInputType.phone;
      case AppInputType.email:
        return TextInputType.emailAddress;
      case AppInputType.password:
        return TextInputType.visiblePassword;
      default:
        return TextInputType.text;
    }
  }

  Widget? buildSuffixIcon({
    required bool showCancelIcon,
    required bool obscureText,
    void Function()? onTap,
  }) {
    if (!showSuffixIcon ||
        ((isReadOnly || !isEnabled) && !forceShowSuffixIcon)) {
      return null;
    }

    if (suffixIcon != null) {
      return suffixIcon;
    }

    if (showCancelIcon) {
      return GestureDetector(
        onTap: () => controller?.clear(),
        child: Container(
          color: Colors.transparent,
          child: const Icon(Icons.cancel, size: 18, color: Colors.grey),
        ),
      );
    }

    if (showEyeIcon) {
      IconData icon = Icons.visibility_off;
      if (obscureText) {
        icon = Icons.visibility;
      }

      return GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          child: Icon(icon, color: Colors.grey),
        ),
      );
    }

    return decoration?.suffixIcon;
  }
}
