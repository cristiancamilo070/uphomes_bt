import 'package:samay_test/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:samay_test/core/widgets/inputs/extensions/app_input_decoration_extension.dart';
import 'package:samay_test/core/widgets/inputs/extensions/app_input_parameters_extension.dart';
import 'package:samay_test/core/widgets/inputs/extensions/app_input_parameters_validator_extension.dart';
import 'package:samay_test/core/widgets/inputs/src/text_field/app_input_parameters.dart';
import 'package:samay_test/core/widgets/inputs/src/text_field/text_field_with_state_widget.dart';

class AppTextFormFieldWidget extends StatelessWidget {
  final AppInputParameters inputParameters;
  const AppTextFormFieldWidget(this.inputParameters, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFieldWithStateWidget(
      parameters: inputParameters,
      childBuilder: (AppInputParameters parameters) {
        return TextFormField(
          onTap: parameters.onTap,
          obscureText: parameters.obscureText,
          readOnly: parameters.isReadOnly,
          enabled: parameters.isEnabled,
          // style: TextStyle(color: AppTheme.colors.textContent),
          cursorColor: Colors.black,
          onChanged: parameters.onChanged,
          maxLength: parameters.maxLength,
          autovalidateMode: parameters.autovalidateMode,
          textInputAction: parameters.textInputAction,
          controller: parameters.controller,
          // decoration: parameters.decoration,
          decoration: parameters.inputDecoration,
          inputFormatters: parameters.textInputFormatter,
          validator: parameters.inputValidator,
          keyboardType: parameters.keyboardType,
          minLines: parameters.minLines,
          maxLines: parameters.maxLines ?? 1,
          // textAlign: TextAlign.center,
          style: AppTheme.style.regular.copyWith(
              // color: AppTheme.colors.white,
              ),
          onTapOutside: (event) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
        );
      },
    );
  }
}
