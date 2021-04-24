import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final Function(String) onSaved;
  final Function(String) validator;
  final Function onTapFormField;
  final bool enabled;
  final bool readOnly;
  final bool obscure;
  final List<TextInputFormatter> inputFormatters;
  final Color style;
  final Color inputColor;

  const TextFormFieldWidget({
    Key key,
    this.label = "",
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.onSaved,
    this.enabled,
    this.obscure = false,
    this.inputFormatters,
    this.onTapFormField,
    this.readOnly = false,
    this.validator,
    this.style = Colors.white,
    this.inputColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: style,
      style: TextStyle(color: style, fontSize: 18),
      obscureText: obscure,
      readOnly: readOnly,
      onChanged: onChanged,
      onSaved: onSaved,
      keyboardType: keyboardType,
      onTap: onTapFormField,
      inputFormatters: inputFormatters,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 8),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: inputColor == null ? Colors.white54 : inputColor)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: inputColor == null ? Colors.white24 : inputColor)),
        labelText: label,
        labelStyle: TextStyle(fontSize: 18, color: inputColor == null ? Colors.white54 : inputColor),
      ),
    );
  }
}
