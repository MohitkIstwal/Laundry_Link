import 'package:flutter/material.dart';
import 'package:laundry_link/Staff/component/Staff_Button.dart';
import '../../routes/app_routes.dart';
import '../StaffService/auth/StaffAuthService.dart';

class StaffLoginpage extends StatefulWidget {
  final Function()? onTap;

  const StaffLoginpage({
    super.key,
    required this.onTap,
  });

  @override
  State<StaffLoginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<StaffLoginpage> {
  final TextEditingController _userNamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _obscurePassword = true;

  void login(BuildContext context) async {
    final authService = StaffAuthService();

    try {
      await authService.signInEmailPassword(
          _userNamecontroller.text, _passwordcontroller.text);

      if (!mounted) return;

      Navigator.pushNamed(
        context,
        AppRoutes.staffHome,
        arguments: _userNamecontroller.text,
      );
    } catch (e) {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.store_mall_directory_rounded,
                size: 90,
                color: Color(0xFF800000),
              ),
              const SizedBox(height: 25),
              const Text(
                "Store Login",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF800000),
                ),
              ),
              const SizedBox(height: 40),

              // Username Field
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F6F6), // Reverted lighter shade
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: Colors.grey.shade600), // Darker border
                ),
                child: TextField(
                  controller: _userNamecontroller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Username',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Password Field with toggle
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F6F6), // Reverted lighter shade
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: Colors.grey.shade600), // Darker border
                ),
                child: TextField(
                  controller: _passwordcontroller,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey[700],
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),

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

              // Login Button
              GestureDetector(
                onTap: () => login(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF800000),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("If Not Registered, "),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Register Here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF800000),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
