import 'package:flutter/material.dart';
import 'package:laundry_link/Admin/Services/UserAndServiceList/UserList.dart';
import 'package:laundry_link/User/services/auth/auth_gate.dart';
import '../Admin/Services/UserAndServiceList/StoreList.dart';
import '../Admin/Services/auth/admin_auth_gate.dart';
import '../Staff/StaffScreens/UserScreen.dart';
import '../Staff/StaffService/auth/StaffAuthGate.dart';
import '../User/Screens/HomePage.dart';
import '../User/Screens/SettingPage.dart';
import '../User/Screens/StorePage.dart';
import '../User/Screens/userPage.dart';

class AppRoutes {
  static const String home = '/home';
  static const String userPage = '/userPage';
  static const String authgate = '/authgate';
  static const String setting = '/setting';
  static const String admingate = '/adminauthgate';
  static const String staffgate = '/staffgate';
  static const String storePage = '/storePage';
  static const String storeUser = '/storeUser';
  static const String adminUser = '/adminUser';
  static const String adminStore = '/adminstore';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const Homepage(),
      userPage: (context) => const Userpage(),
      authgate: (context) => const AuthGate(),
      setting: (context) => const SettingPage(),
      admingate: (context) => const AdminAuthGate(),
      staffgate: (context) => const StaffAuthGate(),
      storePage: (context) => const StorePage(),
      storeUser: (context) => const Userscreen(),
      adminUser: (context) => UserList(),
      adminStore: (context) => StoreList(),
    };
  }
}
