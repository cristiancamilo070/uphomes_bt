import 'package:flutter/material.dart';
import 'package:samay_test/core/widgets/inputs/extensions/app_input_decoration_extension.dart';
import 'package:samay_test/core/widgets/inputs/extensions/app_input_parameters_extension.dart';
import 'package:samay_test/core/widgets/inputs/extensions/app_input_parameters_validator_extension.dart';
import 'package:samay_test/core/widgets/inputs/src/text_field/app_input_parameters.dart';
import 'package:samay_test/core/widgets/inputs/src/text_field/text_field_with_state_widget.dart';

class AppTextFieldWidget extends StatelessWidget {
  final AppInputParameters inputParameters;
  const AppTextFieldWidget(this.inputParameters, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFieldWithStateWidget(
      parameters: inputParameters,
      childBuilder: (AppInputParameters parameters) {
        return TextField(
          obscureText: parameters.obscureText,
          readOnly: parameters.isReadOnly,
          enabled: parameters.isEnabled,
          onTap: parameters.onTap,
          // style: TextStyle(color: AppTheme.colors.textContent),
          cursorColor: Colors.black,
          onChanged: parameters.onChanged,
          maxLength: parameters.maxLength,
          textInputAction: parameters.textInputAction,
          controller: parameters.controller,
          // decoration: parameters.decoration,
          inputFormatters: parameters.textInputFormatter,
          // validator: parameters.inputValidator,
          keyboardType: parameters.keyboardType,
          minLines: parameters.minLines,
          maxLines: parameters.maxLines ?? 1,
          decoration: parameters.inputDecoration,
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
