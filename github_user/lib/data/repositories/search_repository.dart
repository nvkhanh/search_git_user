import 'package:github_user/configs/constants.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/search_user_response.dart';
class SearchRepository {

  Client client;
  SearchRepository(this.client);

  Future<SearchUserResponse> searchUser(String searchText) async {
    var apiFullPath = "${Constants.baseURL}search/users?q=$searchText";
    final http.Response response = await client.get(Uri.parse(apiFullPath));
    if (response.statusCode == 200) {
      return SearchUserResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('An error occurred while connecting to server');
    }
  }
  Future<User> getUserProfile(String username) async {
    var apiFullPath = "${Constants.baseURL}users/$username";
    final http.Response response = await client.get(Uri.parse(apiFullPath));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('An error occurred while connecting to server');
    }
  }
}
