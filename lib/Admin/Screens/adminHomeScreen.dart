import 'package:flutter/material.dart';
import 'package:laundry_link/Admin/components/admin_my_button.dart';
import 'package:laundry_link/Admin/components/admin_my_drawer.dart';
import 'package:laundry_link/routes/app_routes.dart';

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
      body: Column(
        children: [
          MyButton(
              text: "Users List",
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.adminUser);
              },
              color: Colors.grey,
              textColor: Colors.white),
          const SizedBox(height: 30),
          MyButton(
              text: "Stores List",
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.adminStore);
              },
              color: Colors.grey,
              textColor: Colors.white),
        ],
      ),
    );
  }
}
