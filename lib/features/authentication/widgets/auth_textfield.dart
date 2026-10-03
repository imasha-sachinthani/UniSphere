import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      controller: widget.controller,
      obscureText: _obscure,

      style: TextStyle(
        color: isDark ? Colors.white : Colors.black,
      ),

      cursorColor: Colors.blue,

      decoration: InputDecoration(
        hintText: widget.hintText,

        hintStyle: TextStyle(
          color: isDark
              ? Colors.grey.shade500
              : Colors.grey.shade600,
        ),

        prefixIcon: Icon(
          widget.prefixIcon,
          color: isDark
              ? Colors.grey.shade400
              : Colors.grey.shade600,
        ),

        suffixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            _obscure
                ? Icons.visibility_off
                : Icons.visibility,
            color: isDark
                ? Colors.grey.shade400
                : Colors.grey.shade600,
          ),
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
        )
            : null,

        filled: true,

        fillColor: isDark
            ? const Color(0xFF1E1E1E)
            : Colors.grey.shade100,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: isDark
                ? Colors.grey.shade700
                : Colors.grey.shade300,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: isDark
                ? Colors.grey.shade700
                : Colors.grey.shade300,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    );
  }
}