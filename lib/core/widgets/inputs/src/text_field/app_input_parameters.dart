import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_input_parameters.freezed.dart';

@Freezed()
class AppInputParameters with _$AppInputParameters {
  @Assert(
    '!(showEyeIcon == showCancelIcon) || (!showEyeIcon || !showCancelIcon)',
    'only one of them',
  )
  @Assert(
    'isRequired == true && requiredErrorMessage != null || isRequired == false',
    'The message is necessary for required fields',
  )
  factory AppInputParameters({
    String? hintText,
    required String labelText,
    required bool isRequired,
    required AppInputType inputType,
    required BuildContext context,
    // TextInputType? keyboardType,
    FloatingLabelBehavior? floatingLabelBehavior,
    @Default(true) bool showSuffixIcon,
    @Default(false) bool obscureText,
    @Default(false) bool isReadOnly,
    @Default(true) bool isEnabled,
    @Default(false) bool showEyeIcon,
    @Default(false) bool showCancelIcon,
    @Default(true) bool autoDisposeController,
    @Default(false) bool forceShowSuffixIcon,
    @Default(AutovalidateMode.onUserInteraction)
    AutovalidateMode autovalidateMode,
    String? requiredErrorMessage,
    // void Function()? handleHidePassword,
    // void Function(String?)? validatorCallBack,
    // void Function(bool?)? isErrorValidator,
    String? Function(String?)? validator,
    String? Function(String?, AppInputType)? customValidator,
    int? minLines,
    int? maxLines,
    int? maxLength,
    Widget? suffixIcon,
    Widget? prefixIcon,
    // String? errorText,
    // Widget? errorWidget,
    TextInputAction? textInputAction,
    TextEditingController? controller,
    VoidCallback? suffixOnPressed,
    InputDecoration? decoration,
    ValueChanged<String>? onSubmitted,
    ValueChanged<String>? onChanged,
    List<TextInputFormatter>? inputFormatters,
    void Function()? onTap,
  }) = _AppInputParameters;
}

enum AppInputType {
  alphabet,
  text,
  number,
  phone,
  email,
  password,
  textAndNumbers,
  dropdownMenu,
  money,
}
