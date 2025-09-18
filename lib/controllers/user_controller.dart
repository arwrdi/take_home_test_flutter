// lib/controllers/user_controller.dart

import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserController extends GetxController with StateMixin<List<UserModel>> {
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      change([], status: RxStatus.loading());
      final users = await _apiService.fetchUsers();
      if (users.isEmpty) {
        change(users, status: RxStatus.empty());
      } else {
        change(users, status: RxStatus.success());
      }
    } catch (e) {
      change(
        [],
        status: RxStatus.error(
          "Gagal memuat data pengguna. Silakan coba lagi.",
        ),
      );
    }
  }
}
