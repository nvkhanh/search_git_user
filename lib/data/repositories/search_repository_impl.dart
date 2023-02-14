import 'package:github_user/configs/constants.dart';
import 'package:github_user/domain/repositories.dart';
import 'package:github_user/domain/user_entity.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/search_user_response.dart';
class SearchRepositoryImpl implements SearchRepository {

  Client client;
  SearchRepositoryImpl(this.client);



  Future<UserEntity> getUserProfile(String username) async {
    var apiFullPath = "${Constants.baseURL}users/$username";
    final http.Response response = await client.get(Uri.parse(apiFullPath));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body)).toEntity();
    } else {
      throw Exception('An error occurred while connecting to server');
    }
  }

  @override
  Future<List<UserEntity>> searchUser(String username) async {
    var apiFullPath = "${Constants.baseURL}search/users?q=$username";
    final http.Response response = await client.get(Uri.parse(apiFullPath));
    if (response.statusCode == 200) {
      var res = SearchUserResponse.fromJson(jsonDecode(response.body));
      return res.items.map((e) => e.toEntity()).toList();
    } else {
      throw Exception('An error occurred while connecting to server');
    }
  }
}
