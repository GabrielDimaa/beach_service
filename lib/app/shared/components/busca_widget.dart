import 'package:beach_service/app/shared/components/form/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beach_service/app/shared/extensions/string_extension.dart';

class BuscaWidget extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final Function(String) onChanged;
  final Function(String) validator;
  final Function onTapFormField;
  final Function onTapClear;
  final bool enabled;

  const BuscaWidget({
    this.label = "",
    this.textEditingController,
    this.textInputType,
    this.onChanged,
    this.onTapFormField,
    this.onTapClear,
    this.enabled = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormFieldWidget(
          label: label,
          controller: textEditingController,
          onTapFormField: onTapFormField,
          validator: validator,
          readOnly: true,
        ),
        Visibility(
          visible: textEditingController.text.notIsNullOrEmpty(),
          child: Align(
            alignment: Alignment.centerRight,
            heightFactor: 1.2,
            child: IconButton(
              icon: Icon(Icons.cancel, color: Colors.white70),
              iconSize: 25,
              splashRadius: 35,
              onPressed: onTapClear,
            ),
          ),
        ),
      ],
    );
  }
}
