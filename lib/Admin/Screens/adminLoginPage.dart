import 'package:flutter/material.dart';
import '../Services/auth/admin_auth_service.dart';
import '../components/admin_my_button.dart';

class AdminLoginpage extends StatefulWidget {
  final Function()? onTap;

  const AdminLoginpage({
    super.key,
    required this.onTap,
  });

  @override
  State<AdminLoginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<AdminLoginpage> {
  final TextEditingController _userNamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  bool _obscurePassword = true;

  void login(BuildContext context) async {
    final authService = AdminAuthService();

    try {
      await authService.signInEmailPassword(
        _userNamecontroller.text,
        _passwordcontroller.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.toString()),
        ),
      );
    }
  }

  Widget buildCustomField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F6F6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade600),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // Ensures the content is centered vertically and horizontally
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.admin_panel_settings_rounded,
                size: 90,
                color: Color(0xFFFF6F00), // Orange theme
              ),
              const SizedBox(height: 20),
              const Text(
                "Admin Login",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6F00),
                ),
              ),
              const SizedBox(height: 40),
              buildCustomField(
                controller: _userNamecontroller,
                hintText: 'Username',
              ),
              const SizedBox(height: 20),
              buildCustomField(
                controller: _passwordcontroller,
                hintText: 'Password',
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "*Terms and Conditions apply",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              MyButton(
                text: 'Login',
                onTap: () => login(context),
                color: const Color(0xFFFF6F00), // Orange Button
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
