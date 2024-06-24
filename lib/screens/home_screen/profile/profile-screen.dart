import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/features/user/data/user_profile_data.dart';
import 'package:myapp/features/user/repositories/auth_repository.dart';
import 'package:myapp/screens/home_screen/profile/profile-menu-widget.dart';

class ProfileScreen extends HookConsumerWidget {
  final ProfileResponse? profileData;
  const ProfileScreen({super.key, this.profileData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    void _toggleLogout() async {
      final isCleared = await ref.read(resetStorage);
      await removeAsscessToken();
      debugPrint("IS CLEARED ${isCleared}");
      if (isCleared) {
        Navigator.popAndPushNamed(context, 'Login');
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_left_rounded), onPressed: () {}),
        title: Text("Profile",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark
                  ? Icons.brightness_4_rounded
                  : Icons.brightness_3_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(profileData?.avatarUrl ?? ""),
                ),
              ),
              const SizedBox(height: 10),
              Text(profileData?.fullName ?? "",
                  style: Theme.of(context).textTheme.headlineMedium),
              Text(profileData?.email ?? "",
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text("Edit Profile",
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(
                thickness: 0.2,
              ),
              const SizedBox(height: 10),

              //Menu
              ProfileMenuWidget(
                title: "Settings",
                endIcon: true,
                icon: Icons.settings,
                onPressed: () {},
              ),

              ProfileMenuWidget(
                title: "Permissions",
                endIcon: true,
                icon: Icons.lock_open_outlined,
                onPressed: () {},
              ),

              ProfileMenuWidget(
                title: "User Management",
                endIcon: true,
                icon: Icons.person_4_rounded,
                onPressed: () {},
              ),

              const Divider(
                thickness: 0.2,
              ),

              ProfileMenuWidget(
                title: "Information",
                endIcon: true,
                icon: Icons.info_outlined,
                onPressed: () {},
              ),

              ProfileMenuWidget(
                title: "Logout",
                endIcon: false,
                icon: Icons.logout_rounded,
                onPressed: _toggleLogout,
                textColor: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
