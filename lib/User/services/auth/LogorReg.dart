import 'package:flutter/material.dart';
import 'package:laundry_link/User/Screens/Login/LoginPage.dart';
import '../../Screens/SignUp/RegsiterPage.dart';

class LogOrReg extends StatefulWidget {
  const LogOrReg({super.key});

  @override
  State<LogOrReg> createState() => _LogOrRegState();
}

class _LogOrRegState extends State<LogOrReg> {
  bool showLoginPage = true;

  void togglePage(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return Loginpage(onTap: togglePage);
    }
    else{
      return RegisterPage(onTap: togglePage);
    }
  }
}
