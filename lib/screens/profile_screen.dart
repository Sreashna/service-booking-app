import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/theme_controller.dart';
import '../theme/app_color.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final user = FirebaseAuth.instance.currentUser;
  final ThemeController themeController =
  Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            CircleAvatar(
              radius: 45,
              backgroundColor: AppColors.primary,
              child: const Icon(
                Icons.person,
                size: 45,
                color: AppColors.white,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              user?.email ?? "No Email",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 5),

            Text(
              "User ID: ${user?.uid ?? ''}",
              style: Theme.of(context).textTheme.bodySmall,
            ),

            const SizedBox(height: 30),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Obx(() => SwitchListTile(
                title: const Text("Dark Mode"),
                value: themeController.isDarkMode.value,
                onChanged: (value) {
                  themeController.toggleTheme();
                },
              )),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.offAllNamed("/login");
                },
                child: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}