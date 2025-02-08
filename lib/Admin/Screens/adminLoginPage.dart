import 'package:flutter/material.dart';
import '../Services/auth/admin_auth_service.dart';
import '../components/admin_my_button.dart';
import '../components/admin_my_textField.dart';

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

  void login(BuildContext context) async {
    final authService = AdminAuthService();

    try{
      await authService.signInEmailPassword(_userNamecontroller.text, _passwordcontroller.text);
    }catch(e){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString()),
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.message,
              size: 70,
            ),
            const SizedBox(height: 30),


            MyTextField(htext: 'Username', obscureText: false, controller: _userNamecontroller),

            const SizedBox(height: 20),

            MyTextField(htext: 'Password', obscureText: true, controller: _passwordcontroller),

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
              text: 'Login',
              onTap: () => login(context),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "If Not Registered,",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Register Here",
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
