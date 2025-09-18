import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  final String _baseUrl = 'https://reqres.in';

  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/api/users'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['data'] is List) {
          return (data['data'] as List)
              .map((json) => UserModel.fromJson(json))
              .toList();
        }
      }
      throw Exception('Failed to load users');
    } catch (e) {
      throw Exception('Failed to connect to API: $e');
    }
  }
}
