import 'package:flutter/material.dart';
import 'package:laundry_link/routes/app_routes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _selectedRole = 'User';

  final Map<String, String> _roleRoutes = {
    'User': AppRoutes.authgate,
    'Admin': AppRoutes.admingate,
    'Staff': AppRoutes.staffgate,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text("Welcome"),
        backgroundColor: const Color(0xFF64B5F6),
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                _selectedRole = value;
              });
            },
            itemBuilder: (BuildContext context) {
              return ['User', 'Admin', 'Staff']
                  .map((role) => PopupMenuItem(
                        value: role,
                        child: Text(role),
                      ))
                  .toList();
            },
            icon: const Icon(Icons.more_vert, color: Colors.white),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Center Logo
            const Icon(
              Icons.local_laundry_service,
              size: 100,
              color: Color(0xFF42A5F5),
            ),
            const SizedBox(height: 20),
            const Text(
              "Laundry Link",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 40),
            // Card Below Icon, Centered
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                child: ElevatedButton.icon(
                  icon:
                      Icon(_getIconForRole(_selectedRole), color: Colors.white),
                  label: Text(
                    "Continue as $_selectedRole",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF64B5F6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, _roleRoutes[_selectedRole]!);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForRole(String role) {
    switch (role) {
      case 'Admin':
        return Icons.admin_panel_settings;
      case 'Staff':
        return Icons.badge;
      case 'User':
      default:
        return Icons.person;
    }
  }
}
