import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final Function onTapFormField;
  final bool enabled;
  final bool readOnly;
  final bool obscure;
  final List<TextInputFormatter> inputFormatters;

  const TextFormFieldWidget({
    Key key,
    this.label = "",
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.enabled,
    this.obscure = false,
    this.inputFormatters,
    this.onTapFormField,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white, fontSize: 18),
      obscureText: obscure,
      readOnly: readOnly,
      onChanged: onChanged,
      keyboardType: keyboardType,
      onTap: onTapFormField,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 8),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
        labelText: label,
        labelStyle: TextStyle(fontSize: 18, color: Colors.white54),
      ),
    );
  }
}
