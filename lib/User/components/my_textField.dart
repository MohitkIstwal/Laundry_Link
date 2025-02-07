import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String htext;
  final bool obscureText;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.htext,
    required this.obscureText,
    required this.controller,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        obscureText: _isObscured,
        controller: widget.controller,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          fillColor: Colors.grey,
          filled: true,
          hintText: widget.htext,
          hintStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
            icon: Icon(
              _isObscured ? Icons.visibility_off : Icons.visibility,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}
