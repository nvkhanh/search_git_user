
import 'package:github_user/domain/repositories/repositories.dart';
import 'package:github_user/domain/entities/user_entity.dart';

class SearchUserUseCase {
  final SearchRepository repository;
  SearchUserUseCase(this.repository);

  Future<List<UserEntity>> execute(String username) async {
    var res = await repository.searchUser(username);
    return res;
  }
  Future<UserEntity> findProfile(String username) async {
    var res = await repository.getUserProfile(username);
    return res;
  }

}