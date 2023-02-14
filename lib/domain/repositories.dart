
import 'package:github_user/domain/user_entity.dart';


abstract class SearchRepository {
  Future<List<UserEntity>> searchUser(String username);
  Future<UserEntity> getUserProfile(String username);
}