import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class UserListPage extends StatelessWidget {
  final AuthController authController = Get.find();
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pengguna'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authController.logout(),
          ),
        ],
      ),
      body: userController.obx(
        (state) {
          if (state == null || state.isEmpty) {
            return const Center(child: Text('Tidak ada pengguna.'));
          }
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final UserModel user = state[index];
              return ListTile(
                leading: CircleAvatar(child: Text(user.id.toString())),
                title: Text(user.name),
                subtitle: Text(user.email),
              );
            },
          );
        },
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (error) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
