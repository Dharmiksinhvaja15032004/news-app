import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/liked_screen.dart';
import '../provider/theme_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [

          // 🔥 HEADER (TOP PURPLE PART)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF6A11CB),
                  Color(0xFF2575FC),
                ],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.newspaper, size: 50, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  "News Explorer",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Stay updated",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 🏠 HOME
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          // ❤️ LIKED
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.red),
            title: const Text("Liked News"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LikedScreen(),
                ),
              );
            },
          ),

          // 🌙 THEME
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return ListTile(
                leading: Icon(
                  themeProvider.isDark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                title: const Text("Toggle Theme"),
                onTap: () {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),

          const Divider(),

          // ℹ️ ABOUT
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                  title: Text("News Explorer"),
                  content: Text("Version 1.0\nMade with Flutter 💙"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}