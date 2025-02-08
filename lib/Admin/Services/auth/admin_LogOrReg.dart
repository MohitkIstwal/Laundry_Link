import 'package:flutter/material.dart';
import 'package:laundry_link/Admin/Screens/adminSignupPage.dart';

import '../../Screens/adminLoginPage.dart';

class AdminLogOrReg extends StatefulWidget {
  const AdminLogOrReg({super.key});

  @override
  State<AdminLogOrReg> createState() => _AdminLogOrRegState();
}

class _AdminLogOrRegState extends State<AdminLogOrReg> {
  bool showLoginPage = true;

  void togglePage(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return AdminLoginpage(onTap: togglePage);
    }
    else{
      return AdminSignUpPage(onTap: togglePage);
    }
  }
}
