import 'package:flutter/material.dart';
import 'package:laundry_link/User/services/auth/auth_gate.dart';
import '../Admin/Services/auth/admin_auth_gate.dart';
import '../Staff/StaffService/auth/StaffAuthGate.dart';
import '../User/Screens/HomePage.dart';
import '../User/Screens/SettingPage.dart';
import '../User/Screens/userPage.dart';

class AppRoutes {
  static const String home = '/home';
  static const String userPage = '/userPage';
  static const String authgate = '/authgate';
  static const String setting = '/setting';
  static const String admingate = '/adminauthgate';
  static const String staffgate = '/staffgate';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const Homepage(),
      userPage: (context) => const Userpage(),
      authgate: (context) => const AuthGate(),
      setting: (context) => const SettingPage(),
      admingate: (context) => const AdminAuthGate(),
      staffgate: (context) => const StaffAuthGate(),
    };
  }
}
