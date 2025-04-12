import 'package:flutter/material.dart';
import 'package:laundry_link/User/models/user_model.dart';
import '../../../routes/app_routes.dart';
import '../Services/auth/admin_auth_service.dart';
import '../components/admin_my_button.dart';
import '../components/admin_my_textField.dart';

class AdminSignUpPage extends StatefulWidget {
  final Function()? onTap;

  const AdminSignUpPage({
    super.key,
    required this.onTap,
  });

  @override
  State<AdminSignUpPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<AdminSignUpPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _userNamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();

  void register(BuildContext context) async {
    final authService = AdminAuthService();

    userModel newUser = userModel(
        name: _namecontroller.text,
        userName: _userNamecontroller.text,
        emailId: _emailcontroller.text,
        password: _passwordcontroller.text);

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
                ));
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
              ));
    }
  }

  void registerApply(BuildContext context) async {
    register(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(
          Icons.message,
          size: 70,
        ),
        const SizedBox(height: 30),
        MyTextField(
            htext: 'Name', obscureText: false, controller: _namecontroller),
        const SizedBox(height: 20),
        MyTextField(
            htext: 'Username',
            obscureText: false,
            controller: _userNamecontroller),
        const SizedBox(height: 20),
        MyTextField(
            htext: 'Email', obscureText: false, controller: _emailcontroller),
        const SizedBox(height: 20),
        MyTextField(
            htext: 'Password',
            obscureText: true,
            controller: _passwordcontroller),
        const SizedBox(height: 20),
        MyTextField(
            htext: 'Confirm Password',
            obscureText: true,
            controller: _confirmpasswordcontroller),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "*Term and Conditions apply",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        MyButton(
            text: 'Register',
            onTap: () => registerApply(context),
            color: Colors.grey,
            textColor: Colors.white),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "If Already Registered,",
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
            )
          ],
        )
      ]),
    );
  }
}
