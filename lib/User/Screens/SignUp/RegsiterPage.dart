import 'package:flutter/material.dart';
import 'package:laundry_link/User/models/user_model.dart';
import '../../../routes/app_routes.dart';
import '../../services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _userNamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void register(BuildContext context) async {
    final authService = AuthService();

    userModel newUser = userModel(
      name: _namecontroller.text,
      userName: _userNamecontroller.text,
      emailId: _emailcontroller.text,
      password: _passwordcontroller.text,
    );

    if (_passwordcontroller.text == _confirmpasswordcontroller.text) {
      try {
        await authService.signUpEmailPassword(
          _emailcontroller.text,
          _passwordcontroller.text,
          _userNamecontroller.text,
          newUser,
          context,
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

      Navigator.pushNamed(
        context,
        AppRoutes.home,
        arguments: {'source': 'registerPage', 'data': "Hii"},
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Enter the Same Password"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.app_registration,
                size: 100,
                color: Color(0xFF42A5F5),
              ),
              const SizedBox(height: 20),
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2),
                ),
              ),
              const SizedBox(height: 30),
              _buildModernTextField(
                controller: _namecontroller,
                hint: "Name",
                icon: Icons.person_outline,
                obscure: false,
              ),
              const SizedBox(height: 20),
              _buildModernTextField(
                controller: _userNamecontroller,
                hint: "Username",
                icon: Icons.account_circle_outlined,
                obscure: false,
              ),
              const SizedBox(height: 20),
              _buildModernTextField(
                controller: _emailcontroller,
                hint: "Email",
                icon: Icons.email_outlined,
                obscure: false,
              ),
              const SizedBox(height: 20),
              _buildPasswordField(
                controller: _passwordcontroller,
                hint: "Password",
                icon: Icons.lock_outline,
                obscure: _obscurePassword,
                toggleVisibility: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildPasswordField(
                controller: _confirmpasswordcontroller,
                hint: "Confirm Password",
                icon: Icons.lock_reset_outlined,
                obscure: _obscureConfirmPassword,
                toggleVisibility: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "*Terms and Conditions apply",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildModernButton("Register", () => register(context)),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "If Already Registered, ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login Here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
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

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool obscure,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool obscure,
    required VoidCallback toggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          suffixIcon: IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.blueAccent,
            ),
            onPressed: toggleVisibility,
          ),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildModernButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF64B5F6),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 6,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
