import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../db/sqlite_helper.dart';

class AuthController extends GetxController {
  final http.Client httpClient;
  AuthController({required this.httpClient});

  var isLoggedIn = false.obs;

  Future<void> login(String username, String password) async {
    // Simulasi validasi lokal dengan SQLite
    final user = await SqliteHelper.getUser(username);

    // Jika user tidak ada di DB, anggap login gagal
    if (user == null || user['password'] != password) {
      Get.snackbar('Error', 'Username atau password salah.');
      isLoggedIn.value = false;
      return;
    }

    // Simulasi autentikasi berhasil
    isLoggedIn.value = true;
    Get.offAllNamed('/user_list');
  }

  void logout() {
    isLoggedIn.value = false;
    Get.offAllNamed('/');
  }
}
