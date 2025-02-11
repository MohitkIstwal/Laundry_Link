import 'package:flutter/material.dart';
import 'package:laundry_link/Staff/StaffService/ServiceList/ServiceList.dart';

import '../../Staff/component/UserTIle.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});
  @override
  State<StorePage> createState() => _StorePageState();

}

class _StorePageState extends State<StorePage> {
  ServiceList serviceList = ServiceList();

  @override
  Widget build(BuildContext context) {
  final storeName = ModalRoute.of(context)?.settings.arguments as String?;

  return Scaffold(
      appBar: AppBar(
        title : Text(storeName!),
      ),
      body: _getServiceList(storeName),
    );
  }

  Widget _getServiceList(String storeName){
    return StreamBuilder(
      stream: serviceList.getServiceList(storeName),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching services'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>((storeData) => _buildServiceListItem(storeData))
              .toList(),
        );
      },
    );
  }

  Widget _buildServiceListItem(Map<String,dynamic> userData){
    return UserTile(
      storeName: userData['ServiceName'],
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(title: Text(userData['ServiceName']));
          },
        );
      },
    );
  }
}
