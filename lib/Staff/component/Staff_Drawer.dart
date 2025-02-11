import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../StaffService/auth/StaffAuthService.dart';

class StaffDrawer extends StatelessWidget {
  final String userName;

  const StaffDrawer({
    super.key,
    required this.userName
  });

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
                    leading: const Icon(
                      Icons.home,
                      color:Colors.grey,
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

                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: ListTile(
                    title: const Text(
                      "S E R V I C I E S",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: const Icon(
                      Icons.cleaning_services,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context,
                          AppRoutes.ServiceList,
                          arguments: userName
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
                  final authService = StaffAuthService();
                  await authService.staffSignOut();
                  Navigator.pushReplacementNamed(context, AppRoutes.staffgate);
                },
              ),
            ),
          ],
        )
    );
  }
}