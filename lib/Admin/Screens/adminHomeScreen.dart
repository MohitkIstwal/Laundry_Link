import 'package:flutter/material.dart';
import 'package:laundry_link/Admin/components/admin_my_drawer.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Home"),
        centerTitle: true,

      ),
      drawer: const AdminDrawer(),
    );
  }
}
