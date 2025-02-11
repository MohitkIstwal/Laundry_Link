import 'package:flutter/material.dart';

import '../../../Staff/StaffService/UserService/UserService.dart';
import '../../../Staff/component/UserTIle.dart';
import '../../../routes/app_routes.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
      ),
      body: _buildUserList(),
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
