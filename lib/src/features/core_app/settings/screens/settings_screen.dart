import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';
import 'package:spacemall/src/features/auth/screens/login/login.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    // final userContr = UserController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Settings',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Column(
              children: [],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    print(AuthRepo.instance.uid);
                  },
                  child: const Text('Print User Data'),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () async {
                    AuthRepo.instance
                        .setSignedOut()
                        .then((value) => AuthRepo.instance.signOut());
                    Get.to(() => const Login());
                  },
                  child: const Text('Clear Data'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
