// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:samay_test/core/themes/app_theme.dart';
import 'package:samay_test/core/widgets/inputs/src/text_field/app_input_parameters.dart';

extension AppInputDecorationExtension on AppInputParameters {
  UnderlineInputBorder _borderDefault([Color? sideColor]) {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(width: 1, color: sideColor ?? Colors.transparent),
    );
  }

  InputDecoration get inputDecoration {
    final decoration = this.decoration ?? const InputDecoration();
    return decoration.copyWith(
      hintText: hintText,
      counterText: "",
      labelText: labelText,
      errorMaxLines: 3,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: AppTheme.style.regular.copyWith(
        color: AppTheme.colors.appPrimary,
      ),
      hintStyle: AppTheme.style.regular.copyWith(
        color: Colors.grey,
      ),
      errorStyle: AppTheme.style.regular.copyWith(
        color: AppTheme.colors.appAlert,
      ),
      isDense: true,

      prefixIcon: prefixIcon,
      prefixStyle: TextStyle(color: AppTheme.colors.appGrey, fontSize: 14),
      fillColor: isEnabled
          ? AppTheme.colors.white
          : AppTheme.colors.appGrey.withOpacity(0.05),
      filled: true,
      suffixIcon: suffixIcon,
      // suffixIcon: Icon(Icons.ac_unit_rounded),
      prefixIconConstraints: const BoxConstraints(),
      // counter: const Text(""),
      disabledBorder: _borderDefault(AppTheme.colors.appGrey),
      enabledBorder: _borderDefault(AppTheme.colors.appGrey),
      focusedBorder: _borderDefault(AppTheme.colors.appPrimary),

      focusedErrorBorder: _borderDefault(AppTheme.colors.appAlert),
      errorBorder: _borderDefault(AppTheme.colors.appAlert),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        // borderSide: BorderSide.none,
      ),
    );
  }
}
