import 'package:flutter/material.dart';
import 'package:laundry_link/routes/app_routes.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLoginButton(
              context,
              icon: Icons.person,
              text: "User Login",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.authgate);
              },
            ),
            _buildLoginButton(
              context,
              icon: Icons.admin_panel_settings,
              text: "Admin Login",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.admingate);
              },
            ),
            _buildLoginButton(
              context,
              icon: Icons.badge,
              text: "Staff Login",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.staffgate);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, {required IconData icon, required String text, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 24),
        label: Text(text, style: TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
