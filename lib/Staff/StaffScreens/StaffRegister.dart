import 'package:flutter/material.dart';
import '../StaffService/auth/StaffAuthService.dart';
import '../component/Staff_Button.dart';
import '../model/StaffModel.dart';

class StaffSignUpPage extends StatefulWidget {
  final Function()? onTap;

  const StaffSignUpPage({
    super.key,
    required this.onTap,
  });

  @override
  State<StaffSignUpPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<StaffSignUpPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _userNamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();
  final TextEditingController _storecontroller = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void register(BuildContext context) async {
    final authService = StaffAuthService();

    StaffModel newUser = StaffModel(
      name: _namecontroller.text,
      userName: _userNamecontroller.text,
      emailId: _emailcontroller.text,
      password: _passwordcontroller.text,
      storeName: _storecontroller.text,
    );

    if (_passwordcontroller.text == _confirmpasswordcontroller.text) {
      try {
        await authService.signUpEmailPassword(
            _emailcontroller.text,
            _passwordcontroller.text,
            _userNamecontroller.text,
            newUser,
            context);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Enter the Same Password"),
        ),
      );
    }
  }

  void registerApply(BuildContext context) async {
    register(context);
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.store_mall_directory_rounded,
              size: 90,
              color: Color(0xFF800000),
            ),
            const SizedBox(height: 20),
            const Text(
              "Register Your Store",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF800000),
              ),
            ),
            const SizedBox(height: 40),
            buildCustomField(controller: _namecontroller, hintText: 'Name'),
            const SizedBox(height: 20),
            buildCustomField(
                controller: _userNamecontroller, hintText: 'Username'),
            const SizedBox(height: 20),
            buildCustomField(
                controller: _storecontroller, hintText: 'Store Name'),
            const SizedBox(height: 20),
            buildCustomField(controller: _emailcontroller, hintText: 'Email'),
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
            buildCustomField(
              controller: _confirmpasswordcontroller,
              hintText: 'Confirm Password',
              obscureText: _obscureConfirmPassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey[700],
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
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
            StaffButton(
              text: 'Register',
              onTap: () => registerApply(context),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("If Already Registered, "),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    "Login Here",
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
    );
  }
}
