import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundry_link/Staff/StaffService/UserService/UserService.dart';
import 'package:laundry_link/Staff/component/Staff_Drawer.dart';
import 'package:laundry_link/User/services/fetchData/FetchData.dart';

import '../../routes/app_routes.dart';
import '../component/UserTIle.dart';

class StaffHome extends StatefulWidget {
  const StaffHome({super.key});
  @override
  State<StaffHome> createState() => _StaffHomeState();
}

class _StaffHomeState extends State<StaffHome> {

  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
  final String? userName = ModalRoute.of(context)?.settings.arguments as String?;

  return Scaffold(
      appBar: AppBar(
        title:  Text(userName ?? "Hii"),
        centerTitle: true,
      ),
      drawer: StaffDrawer(userName: userName!),
      body : _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(
        stream: userService.getUserList(),
        builder: (context,snapshot) {
          if(snapshot.hasError){
            return const Text('Error');
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Text('Loading...');
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _buildUserListItem(userData))
                .toList(),
          );
        }
    );
  }

  Widget _buildUserListItem(Map<String,dynamic> userData){
    return UserTile(
      storeName: userData['userName'],
      onTap: (){
        Navigator.pushNamed(
            context,
            AppRoutes.storeUser,
            arguments:userData['userName']
        );
      }
    );
  }
}
