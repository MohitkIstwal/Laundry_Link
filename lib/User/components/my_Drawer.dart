import 'package:flutter/material.dart';
import 'package:laundry_link/User/services/auth/auth_service.dart';
import 'package:laundry_link/routes/app_routes.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    bool isDarkMode = false;
    return Drawer(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const DrawerHeader(
                    child: Center(
                      child: Icon(
                        Icons.message,
                        color: Colors.grey,
                        size: 40,
                      ),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: ListTile(
                    title: const Text(
                      "H O M E",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(
                      Icons.home,
                      color: isDarkMode? Colors.white : Colors.grey,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: ListTile(
                    title: const Text(
                      "S E T T I N G",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: const Icon(
                      Icons.settings,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context,
                          AppRoutes.setting
                      );
                    },
                  ),
                ),

              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, bottom: 25),
              child: ListTile(
                title: const Text(
                  "L O G O U T",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.grey,
                ),
                onTap: () async {
                  final authService = AuthService();
                  await authService.signOut();
                  Navigator.pushReplacementNamed(context, AppRoutes.authgate);
                },
              ),
            ),
          ],
        )
    );
  }
}