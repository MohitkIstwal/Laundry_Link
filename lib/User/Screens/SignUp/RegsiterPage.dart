import 'package:flutter/material.dart';
import '../../components/my_button.dart';
import '../../components/my_textField.dart';
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
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller = TextEditingController();

  void  register(BuildContext context) async {
    final authService = AuthService();

    if(_passwordcontroller.text == _confirmpasswordcontroller.text){
      try{
         await authService.signUpEmailPassword(_emailcontroller.text, _passwordcontroller.text);
      }catch(e){
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Error"),
              content: Text(e.toString()),
            )
        );
      }
    }else{
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Enter the Same Password"),
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
              Icons.add,
              size: 70,
            ),
            const SizedBox(height: 30),

            MyTextField(htext: 'Email', obscureText: false, controller: _emailcontroller),

            const SizedBox(height: 20),

            MyTextField(htext: 'Password', obscureText: true, controller: _passwordcontroller),

            const SizedBox(height: 20),

            MyTextField(htext: 'Confirm Password', obscureText: true, controller: _confirmpasswordcontroller),

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
              onTap: () => register(context),
            ),

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
