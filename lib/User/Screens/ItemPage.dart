import 'package:flutter/material.dart';
import 'package:laundry_link/Staff/StaffService/ServiceList/ServiceList.dart';

class Itempage extends StatefulWidget {
  const Itempage({super.key});

  @override
  State<Itempage> createState() => _ItempageState();
}

class _ItempageState extends State<Itempage> {
  final ServiceList serviceList = ServiceList();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String storeName = args?['storeName'];
    final String serviceName = args?['serviceName'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Items"),
        centerTitle: true,
        backgroundColor: const Color(0xFF42A5F5),
      ),
      body: _getItemList(storeName, serviceName),
      backgroundColor: const Color(0xFFF0F8FF), // Light blue background
    );
  }

  Widget _getItemList(String storeName, String serviceName) {
    return StreamBuilder<List<String>>(
      stream: serviceList.getItemList(storeName, serviceName),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching items'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No items available"));
        }

        final items = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4 / 5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return _buildItemCard(items[index]);
            },
          ),
        );
      },
    );
  }

  Widget _buildItemCard(String itemName) {
    return GestureDetector(
      onTap: () {
        // Add any navigation or action here
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag,
              size: 50,
              color: Color(0xFF42A5F5),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                itemName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1976D2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
