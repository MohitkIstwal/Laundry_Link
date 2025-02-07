import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        actions: [
          IconButton(
              onPressed: authService.signOut,
              icon : Icon(Icons.logout))
        ],
      ),
    );
  }
}
