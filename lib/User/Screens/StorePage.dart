import 'package:flutter/material.dart';
import 'package:laundry_link/Staff/StaffService/ServiceList/ServiceList.dart';
import '../../routes/app_routes.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final ServiceList serviceList = ServiceList();

  @override
  Widget build(BuildContext context) {
    final storeName = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text(storeName ?? 'Store'),
        backgroundColor: const Color(0xFF42A5F5),
      ),
      body: _getServiceList(storeName!),
      backgroundColor: const Color(0xFFF0F8FF), // Light blueish background
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

        final services = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: services.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.8 / 4.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return _buildServiceCard(services[index], storeName);
            },
          ),
        );
      },
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> serviceData, String storeName) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.UserItemPage,
          arguments: {
            'serviceName': serviceData['ServiceName'],
            'storeName': storeName,
          },
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
                Icons.cleaning_services,
                size: 50,
                color: Color(0xFF42A5F5),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  serviceData['ServiceName'],
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
