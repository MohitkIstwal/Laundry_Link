import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_link/Staff/StaffScreens/StaffHome.dart';
import 'StaffLogOrReg.dart';

class StaffAuthGate extends StatelessWidget {
  const StaffAuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if(snapshot.hasData && snapshot.data != null){
              return const StaffHome();
            }else{
              return const StaffLogOrReg();
            }
          }
      ),
    );
  }
}