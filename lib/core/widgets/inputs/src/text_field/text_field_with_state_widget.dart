import 'package:get/get.dart';
import 'package:samay_test/core/widgets/inputs/extensions/app_input_parameters_extension.dart';
import 'package:samay_test/core/widgets/inputs/src/text_field/app_input_parameters.dart';
import 'package:flutter/material.dart';

class TextFieldWithStateWidget extends StatefulWidget {
  final AppInputParameters parameters;
  final Widget Function(AppInputParameters) childBuilder;

  const TextFieldWithStateWidget({
    required this.parameters,
    required this.childBuilder,
    super.key,
  });

  @override
  State<TextFieldWithStateWidget> createState() =>
      _TextFieldWithStateWidgetState();
}

class _TextFieldWithStateWidgetState extends State<TextFieldWithStateWidget> {
  bool _obscureText = false;
  bool _showCancelIcon = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.parameters.obscureText;
    widget.parameters.controller?.addListener(_handleHideCancelIcon);
  }

  @override
  void dispose() {
    super.dispose();
    if (_parameters.autoDisposeController) {
      _parameters.controller?.dispose();
      Get.log('[${_parameters.labelText}] - Has be deleted');
    }
  }

  AppInputParameters get _parameters {
    return widget.parameters.copyWith(
      obscureText: _obscureText,
      // controller: widget.parameters.controller,
      suffixIcon: widget.parameters.buildSuffixIcon(
        showCancelIcon: _showCancelIcon,
        obscureText: _obscureText,
        onTap: _handleHidePassword,
      ),
    );
  }

  void _handleHideCancelIcon() {
    if (widget.parameters.controller != null) {
      final inputValue = _parameters.controller!.text;
      if (inputValue.isEmpty && _parameters.showCancelIcon) {
        if (_showCancelIcon) {
          setState(() => _showCancelIcon = false);
        }
      } else if (!_showCancelIcon && _parameters.showCancelIcon) {
        setState(() => _showCancelIcon = true);
      }
    }
  }

  void _handleHidePassword() {
    if (_parameters.showEyeIcon) {
      setState(() => _obscureText = !_obscureText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.childBuilder.call(_parameters);
  }
}
