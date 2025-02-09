import 'package:flutter/material.dart';
import 'package:laundry_link/routes/app_routes.dart';
import '../../components/my_button.dart';
import '../../components/my_textField.dart';
import '../../services/auth/auth_service.dart';

class Loginpage extends StatefulWidget {
  final Function()? onTap;

  const Loginpage({
    super.key,
    required this.onTap,
  });

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  final TextEditingController _userNamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  void login(BuildContext context) async {
    final authService = AuthService();

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

    Navigator.pushNamed(
      context,
      AppRoutes.home,
      arguments: {'source' : 'login', 'data': _userNamecontroller.text},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.add,
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
