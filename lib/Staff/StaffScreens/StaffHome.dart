import 'package:flutter/material.dart';
import 'package:laundry_link/Staff/component/Staff_Drawer.dart';

class StaffHome extends StatefulWidget {
  const StaffHome({super.key});

  @override
  State<StaffHome> createState() => _StaffHomeState();
}

class _StaffHomeState extends State<StaffHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Staff Home"),
        centerTitle: true,
      ),
      drawer: StaffDrawer(),
    );
  }
}
