import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Screens/adminHomeScreen.dart';
import 'admin_LogOrReg.dart';

class AdminAuthGate extends StatelessWidget {
  const AdminAuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if(snapshot.hasData && snapshot.data != null){
              return const AdminHomeScreen();
            }else{
              return const AdminLogOrReg();
            }
          }
      ),
    );
  }
}