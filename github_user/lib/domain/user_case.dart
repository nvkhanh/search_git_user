
import 'package:github_user/domain/repositories.dart';
import 'package:github_user/domain/user_entity.dart';

class SearchUserUseCase {
  final SearchRepository repository;
  SearchUserUseCase(this.repository);
  Future<List<UserEntity>> execute(String username) async {
    var res = await repository.searchUser(username);
    return res;
  }

}