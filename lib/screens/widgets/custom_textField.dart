import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
   const CustomTextfield({super.key,
      this.obscureText = true,
     required this.label,
      this.icon,
     required this.textInputType,
     required this.controller,
     this.validate,
     this.suffixIcon});

 final TextEditingController controller;
  final bool obscureText;
  final String label;
  final Icon? icon;
  final TextInputType textInputType;
  final String? Function(String?)? validate;
  final IconButton? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validate,
      keyboardType: textInputType,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        label: Text(label),
        prefixIcon: icon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          //borderSide: BorderSide.none
        )
      ),

    );
  }
}
