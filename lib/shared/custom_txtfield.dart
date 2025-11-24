import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({super.key, required this.hint, required this.isPassword, required this.controller});
  final String hint;
  final bool isPassword;
  final TextEditingController controller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }
  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        cursorHeight: 50,
        style: TextStyle(fontSize: 16,color: Colors.white),
        controller: widget.controller,
        cursorColor: AppColors.primary,
        validator: (v) {
          if(v == null || v.isEmpty) {
            return 'please fill ${widget.hint}';
          }
          null;
        },
        obscureText: _obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          suffixIcon: widget.isPassword ? GestureDetector(
            onTap: _togglePassword,
            child: Icon(CupertinoIcons.eye ,color: Colors.white,size: 19,),
          ) : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.white,width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey,width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red,width: 2),
          ),
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.white),
          fillColor: Colors.transparent.withOpacity(0.3),
          filled: true,
        ),
      ),
    );
  }
}