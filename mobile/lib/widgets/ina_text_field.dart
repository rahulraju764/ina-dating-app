import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class InaTextField extends StatefulWidget {
  final String hint;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixWidget;

  const InaTextField({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.suffixWidget,
  });

  @override
  State<InaTextField> createState() => _InaTextFieldState();
}

class _InaTextFieldState extends State<InaTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword && _obscureText,
      validator: widget.validator,
      onChanged: widget.onChanged,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 15,
        fontFamily: 'Poppins',
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: AppColors.textSecondary, size: 20)
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
                onPressed: () => setState(() => _obscureText = !_obscureText),
              )
            : widget.suffixWidget,
      ),
    );
  }
}
