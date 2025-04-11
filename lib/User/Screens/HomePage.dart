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
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String? username = args?['data'];

    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD), // Light blue background
      appBar: AppBar(
        title: const Text("HOME"),
        backgroundColor: const Color(0xFF42A5F5),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushNamed(
                context,
                AppRoutes.userPage,
                arguments: username,
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _buildStoreGrid(),
      ),
    );
  }

  Widget _buildStoreGrid() {
    return StreamBuilder(
      stream: storeService.getStoreList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final storeList = snapshot.data!;
        return GridView.builder(
          itemCount: storeList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3 / 3.3, // Smaller height
          ),
          itemBuilder: (context, index) {
            final storeData = storeList[index];
            return _buildStoreCard(storeData);
          },
        );
      },
    );
  }

  Widget _buildStoreCard(Map<String, dynamic> storeData) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.storePage,
          arguments: storeData['storeName'],
        );
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.local_laundry_service,
                size: 50,
                color: Color(0xFF42A5F5),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  storeData['storeName'],
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
      ),
    );
  }
}
