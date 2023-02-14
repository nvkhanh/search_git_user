import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_user/data/repositories/search_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';

import '../helpers/json_reader.dart';

@GenerateMocks([http.Client])
void main() {
  setUp(() {

  });

  group('fetch users', () {
    test('returns an list of users if the http call completes successfully', () async {
      // arrange
      final jsonMock = jsonDecode(readJson('helpers/test_resources/dummy_user_response.json'));
      final repository = SearchRepositoryImpl(http.Client());
      repository.client = MockClient((request) async {
        final jsonMap = jsonMock;
        return Response(json.encode(jsonMap), 200);
      });

      // act
      final item = await repository.searchUser('nvkhanh');

      //assert
      expect(item.length, 30);
    });

  });

}