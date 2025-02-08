import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundry_link/User/services/fetchData/FetchData.dart';

import '../components/my_container.dart';

class Userpage extends StatefulWidget {
  const Userpage({super.key});

  @override
  State<Userpage> createState() => _UserpageState();
}

class _UserpageState extends State<Userpage>{

  final FetchData fetchData = FetchData();

  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: _buildUserProfile(username)
    );
  }

  Widget _buildUserProfile(String userId) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchData.fetchUserById("test"), // ✅ Correct way to call future
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // ✅ Show loading
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}")); // ✅ Show error
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("User not found")); // ✅ Handle missing data
        }

        Map<String, dynamic> userData = snapshot.data!;

         return _buildList(userData);
      },
    );
  }

  Widget _buildList(Map<String, dynamic> userData){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.all(50.0),
            child: Icon(
              Icons.account_circle,
              size: 150,
            ),
          ),
        ),
        const SizedBox(height: 20),
        MyContainer(text: "Name", text2: userData["name"] ?? "N/A"),
        const SizedBox(height: 20),
        MyContainer(text: "UserName", text2: userData["userName"] ?? "N/A"),
        const SizedBox(height: 20),
        MyContainer(text: "Email", text2: userData["emailId"] ?? "N/A"),
      ],
    );
  }
}
