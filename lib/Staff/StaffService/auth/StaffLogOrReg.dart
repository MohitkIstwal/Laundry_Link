import 'package:flutter/material.dart';
import '../../StaffScreens/StaffLogin.dart';
import '../../StaffScreens/StaffRegister.dart';

class StaffLogOrReg extends StatefulWidget {
  const StaffLogOrReg({super.key});

  @override
  State<StaffLogOrReg> createState() => _StaffLogOrRegState();
}

class _StaffLogOrRegState extends State<StaffLogOrReg> {
  bool showLoginPage = true;

  void togglePage(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return StaffLoginpage(onTap: togglePage);
    }
    else{
      return StaffSignUpPage(onTap: togglePage);
    }
  }
}
