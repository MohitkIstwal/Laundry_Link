import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundry_link/Staff/StaffService/ServiceList/ServiceList.dart';
import 'package:laundry_link/Staff/model/StaffServiceModel.dart';
import '../../routes/app_routes.dart';
import '../component/UserTIle.dart';

class ServiceListScreen extends StatefulWidget {
  const ServiceListScreen({super.key});

  @override
  State<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  String? storeName;
  String? userName;
  bool isLoading = true; // ✅ Track loading state

  ServiceList serviceList = ServiceList();
  final TextEditingController _textController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Get the userName only once
      userName = ModalRoute.of(context)?.settings.arguments as String?;
      if (userName != null) {
        _fetchStoreName(userName!);
      }
  }

  Future<void> _fetchStoreName(String userId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('staff').doc(userId).get();

      if (doc.exists) {
        setState(() {
          storeName = doc['storeName']; // ✅ Assign storeName from Firestore
          isLoading = false;
        });
      } else {
        setState(() {
          storeName = "Store Not Found";
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching store name: $e");
      setState(() {
        storeName = "Error Fetching Store";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(storeName ?? "Loading..."), // ✅ Show Loading... until data is fetched
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _showAddServiceDialog,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // ✅ Show loader until data is fetched
          : storeName == null
          ? const Center(child: Text("No Store Found")) // ✅ Handle empty store case
          : _getServiceList(storeName!),
    );
  }

  Widget _getServiceList(String storeName) {
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

  Widget _buildServiceListItem(Map<String, dynamic> userData) {
    return UserTile(
      storeName: userData['ServiceName'],
      onTap: () {
          Navigator.pushNamed(
              context,
              AppRoutes.itemList,
              arguments: {'serviceName' : userData['ServiceName'], 'storeName' : storeName!}
          );
      },
    );
  }

  void _showAddServiceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Service Name"),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(hintText: "Service Name"),
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
                  StaffServiceModel ssm = StaffServiceModel(ServiceName: enteredText, ItemList: []);
                  serviceList.createServiceList(enteredText, storeName, ssm);
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
