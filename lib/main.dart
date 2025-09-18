import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'controllers/auth_controller.dart';
import 'db/sqlite_helper.dart';
import 'views/login_page.dart';
import 'views/user_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqliteHelper.initDb();

  await SqliteHelper.saveUser('admin', 'password');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Take-Home Test Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/user_list', page: () => UserListPage()),
      ],
      initialBinding: AuthBinding(),
    );
  }
}

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(httpClient: http.Client()));
  }
}
