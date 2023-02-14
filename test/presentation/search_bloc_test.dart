import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:github_user/data/models/search_user_response.dart';
import 'package:github_user/data/repositories/search_repository_impl.dart';
import 'package:github_user/domain/usecases/use_case.dart';
import 'package:github_user/presentation/bloc/search_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';

import '../helpers/json_reader.dart';


void main() {

  var jsonString = readJson('helpers/test_resources/dummy_user_response.json');
  final userResponse = SearchUserResponse.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
  var userList = userResponse.items.map((e) => e.toEntity()).toList();

  blocTest<SearchUserBloc, SearchUserState>(
    'should emit [loading, has data] when data is gotten successfully',
    build: () {
      // arrange
      final jsonMock = readJson('helpers/test_resources/dummy_user_response.json');
      final repository = SearchRepositoryImpl(http.Client());
      final userCase = SearchUserUseCase(repository);

      repository.client = MockClient((request) async {
        return Response(jsonMock, 200);
      });
      return SearchUserBloc(userCase);
    },
    act: (bloc) => bloc.add(SearchUserRequested('nvkhanh')),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchUserLoadInProgress(),
      SearchUserLoadSuccess(userList)
    ],
  );

  blocTest<SearchUserBloc, SearchUserState>(
    'should emit [loading, error state] when data is not gotten successfully',
    build: () {
      // arrange
      final jsonMock = readJson('helpers/test_resources/dummy_user_response.json');
      final repository = SearchRepositoryImpl(http.Client());
      final userCase = SearchUserUseCase(repository);

      repository.client = MockClient((request) async {
        return Response(jsonMock, 500);
      });
      return SearchUserBloc(userCase);
    },
    act: (bloc) => bloc.add(SearchUserRequested('nvkhanh')),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchUserLoadInProgress(),
      SearchUserLoadFailure(),
    ],
  );


}