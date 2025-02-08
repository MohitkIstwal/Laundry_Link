import 'package:flutter/material.dart';
import 'package:laundry_link/routes/app_routes.dart';
import '../../User/components/my_Drawer.dart';
import '../services/auth/auth_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String? username = args?['data'];

    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pushNamed(context, AppRoutes.userPage,arguments: username);
              },
              icon : const Icon(Icons.person))
        ],
      ),
      drawer: const MyDrawer(),
    );
  }
}