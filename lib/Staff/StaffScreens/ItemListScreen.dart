import 'package:flutter/material.dart';
import 'package:laundry_link/Staff/StaffService/ServiceList/ServiceList.dart';
import '../component/ItemTile.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final TextEditingController _textController = TextEditingController();
  ServiceList serviceList = ServiceList();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    String storeName = args?['storeName'];
    String serviceName = args?['serviceName'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Item List"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _showAddServiceDialog(storeName,serviceName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: _getServiceList(storeName,serviceName),
    );
  }

  Widget _getServiceList(String storeName, String serviceName) {
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
              .map<Widget>((item) => _buildServiceListItem(item, storeName, serviceName)) // ✅ Now passing a string instead of a map
              .toList(),
        );
      },
    );
  }


  Widget _buildServiceListItem(String itemName,String storeName, String serviceName) {
    return ItemListTile(
      items: itemName, // ✅ Pass the item name
      onTap: () {
         serviceList.removeServiceFromStore(storeName, serviceName, itemName);
         showDialog(
             context: context,
             builder: (context){
               return AlertDialog(
                   title: const Text("Deleted"),
                   content: Text("$itemName Deleted Successfully"),
                   actions: [
                     TextButton(onPressed: (){
                       Navigator.pop(context);
                     }, child: const Text("OK"))
                   ],
               );
             }
         );
      },
    );
  }


  void _showAddServiceDialog(String storeName, String serviceName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Items Name"),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(hintText: "Item Name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                String enteredText = _textController.text.trim();
                if (enteredText.isNotEmpty) {
                  serviceList.addServiceToStore(storeName,serviceName, enteredText);
                  _textController.clear();
                }
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

