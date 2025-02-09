import 'package:flutter/material.dart';
import 'package:laundry_link/Staff/component/Staff_Button.dart';

import '../StaffService/auth/StaffAuthService.dart';
import '../component/Staff_TextField.dart';

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

  void login(BuildContext context) async {
    final authService = StaffAuthService();

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

            Text("Staff Login"),

            const SizedBox(height: 30),

            StaffTextField(htext: 'Username', obscureText: false, controller: _userNamecontroller),

            const SizedBox(height: 20),

            StaffTextField(htext: 'Password', obscureText: true, controller: _passwordcontroller),

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

            StaffButton(
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
