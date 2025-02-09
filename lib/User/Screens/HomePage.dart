import 'package:flutter/material.dart';
import 'package:laundry_link/User/components/StoreTile.dart';
import 'package:laundry_link/User/services/storeService/StoreService.dart';
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
  final storeService = StoreService();

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String? username = args?['data'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pushNamed(context, AppRoutes.userPage,arguments: username);
              },
              icon : const Icon(Icons.person))
        ],
      ),
      drawer: const MyDrawer(),
      body: _buildStoreList(),
    );
  }

  Widget _buildStoreList(){
    return StreamBuilder(
        stream: storeService.getStoreList(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return const Text("Error");
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Text('Loading...');
          }
          return ListView(
            children : snapshot.data!
            .map<Widget>((storeData) => _bulidStoreListItem(storeData))
            .toList(),
          );
        }
    );
  }

  Widget _bulidStoreListItem(Map<String,dynamic> storeData){
    return StoreTile(
        storeName: storeData['storeName'],
        onTap: (){
          Navigator.pushNamed(
              context,
              AppRoutes.storePage,
              arguments: storeData['storeName']
          );
        }
    );
  }
}