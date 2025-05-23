import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final double? padding;

  CustomTextFormField({
    required this.label,
    this.obscureText = false,
    this.prefixIconPath,
    this.suffixIconPath,
    this.controller,
    this.validator,  this.padding,

  });

  Widget _buildIcon(String path) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: SvgPicture.asset(path, width: 24, height: 24, fit: BoxFit.contain),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 20, vertical: 8),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: label,
          prefixIcon:
              prefixIconPath != null ? _buildIcon(prefixIconPath!) : null,

          suffixIcon:
              suffixIconPath != null ? _buildIcon(suffixIconPath!) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
      ),
    );
  }
}
