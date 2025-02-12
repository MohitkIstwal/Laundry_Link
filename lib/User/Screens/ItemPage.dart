import 'package:flutter/material.dart';
import 'package:laundry_link/Staff/StaffService/ServiceList/ServiceList.dart';
import 'package:laundry_link/Staff/component/UserTIle.dart';

class Itempage extends StatefulWidget {
  const Itempage({super.key});

  @override
  State<Itempage> createState() => _ItempageState();
}

class _ItempageState extends State<Itempage> {
  ServiceList serviceList = ServiceList();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    String storeName = args?['storeName'];
    String serviceName = args?['serviceName'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Item Page"),
        centerTitle: true,
      ),
      body: _getItemList(storeName,serviceName),
    );
  }

  Widget _getItemList(String storeName, String serviceName) {
    return StreamBuilder<List<String>>(
      stream: serviceList.getItemList(storeName, serviceName), // ✅ Ensure the function returns List<String>
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching services'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No items available"));
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>((item) => _buildItemListItem(item)) // ✅ Now passing a string instead of a map
              .toList(),
        );
      },
    );
  }

  Widget _buildItemListItem(String itemName) {
      return UserTile(
          storeName: itemName,
          onTap: (){}
      );
  }
}
