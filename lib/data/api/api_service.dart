import 'dart:convert';

import 'package:flutter_story_app/data/api/exception/http_exception.dart';
import 'package:flutter_story_app/data/api/response/get_stories_response.dart';
import 'package:flutter_story_app/data/api/response/login_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://story-api.dicoding.dev/v1/';

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await http.post(Uri.parse('${baseUrl}login'),
          body: {'email': email, 'password': password});

      final result = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return LoginResponse.fromJson(result);
      } else {
        throw HttpException(result['message']);
      }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<LoginResponse> register(
      String name, String email, String password) async {
    try {
      final response = await http.post(Uri.parse('${baseUrl}register'),
          body: {'name': name, 'email': email, 'password': password});

      final result = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return LoginResponse.fromJson(result);
      } else {
        throw HttpException(result['message']);
      }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<GetStoriesResponse> getStories(String token) async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}stories'),
          headers: {'Authorization': 'Bearer $token'});

      final result = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return GetStoriesResponse.fromJson(result);
      } else {
        throw HttpException(result['message']);
      }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }
}
