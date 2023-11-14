import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Widget prefix;
  final FocusNode focusNode;
  const TextFieldInput(
      {super.key,
      required this.textEditingController,
      this.isPass = false,
      required this.hintText,
      required this.textInputType,
      required this.prefix,
      required this.focusNode});

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      focusNode: focusNode,
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: prefix,
        filled: true,
        fillColor: Color(0xff9CD2D3),
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xff273431), fontFamily: 'Poppins'),
        border: inputBorder,
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
      style: TextStyle(color: Colors.black),
    );
  }
}
