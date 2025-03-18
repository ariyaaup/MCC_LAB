import 'package:flutter/material.dart';
import 'package:wngine_app/Function/SharedPreferences.dart';
import 'package:wngine_app/Function/SignInGoogle.dart';

class DrawerMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const DrawerMenu({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header Drawer
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.all(15),
            color: const Color.fromARGB(255, 44, 44, 44),
            child: FutureBuilder<String?>(
              future: UserPreference.getUsername(),
              builder: (context, snapshot) {
                final username = snapshot.data ?? "Unknown User";
                final String displayName = snapshot.data ?? "Unknown User";
                return Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    username,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),

          // Konten Drawer dengan Gradient Background
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(42, 42, 42, 0.992),
                    Color.fromARGB(255, 113, 15, 67),
                    Color.fromRGBO(42, 42, 42, 0.992),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: FutureBuilder<String?>(
                future: UserPreference.getUsername(),
                builder: (context, snapshot) {
                  final username = snapshot.data;
                  final bool isGuest = username == "Guest";
                  final bool isLoggedIn = username != null;

                  return ListView(
                    children: [
                      // Jika user belum login, tampilkan Register & Sign In
                      if (username == "Guest") ...[
                        ListTile(
                          leading: const Icon(Icons.app_registration,
                              color: Colors.white),
                          title: const Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/usernameRegist');
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.login, color: Colors.white),
                          title: const Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/loginPage');
                          },
                        ),
                      ],

                      // Jika user login, tampilkan "Home", "Profile" & Log Out
                      if (isLoggedIn) ...[
                        ListTile(
                          leading: const Icon(Icons.logout, color: Colors.red),
                          title: const Text(
                            "Sign Out",
                            style: TextStyle(color: Colors.red),
                          ),
                          onTap: () async {
                            await UserPreference.clearUsername();
                            signOutGoogle(context);
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/splashScreen');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Successfully signed out.")),
                            );
                          },
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
