
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user/domain/user_case.dart';
import 'package:github_user/domain/user_entity.dart';

import '../../data/models/search_user_response.dart';

abstract class SearchUserEvent {}

class SearchUserRequested extends SearchUserEvent {
  SearchUserRequested(this.text);
  final String text;
}
class SearchUserClearText extends SearchUserEvent {}

class SearchUserDetailEvent extends SearchUserEvent {
  final String username;
  SearchUserDetailEvent(this.username);
}


abstract class SearchUserState {}
class SearchUserInitial extends SearchUserState {}
class SearchUserLoadInProgress extends SearchUserState {}
class SearchUserLoadFailure extends SearchUserState {}
class SearchUserLoadSuccess extends SearchUserState {
  SearchUserLoadSuccess(this.userList);
  final List<UserEntity> userList;
}
class SearchUserDetailSuccess extends SearchUserState {
  final User user;
  SearchUserDetailSuccess(this.user);
}


class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  // final SearchRepositoryImpl repository;
  final SearchUserUseCase _searchUserUseCase;
  SearchUserBloc(this._searchUserUseCase) : super(SearchUserInitial()) {
    on<SearchUserRequested>((event, emit) => onSearchUserRequested(event, emit));
    on<SearchUserClearText>((event, emit) => emit(SearchUserInitial()));
    on<SearchUserDetailEvent>((event, emit) => onSearchUserDetailSuccess(event, emit));
  }

  void onSearchUserRequested(SearchUserRequested event, Emitter<SearchUserState> emit) async {
    emit(SearchUserLoadInProgress());
    try {
      final response = await _searchUserUseCase.execute(event.text);
      emit(SearchUserLoadSuccess(response));
    } catch (_) {
      emit(SearchUserLoadFailure());
    }
  }
  void onSearchUserDetailSuccess(SearchUserDetailEvent event, Emitter<SearchUserState> emit) async {
    emit(SearchUserLoadInProgress());
    // try {
    //   final response = await repository.getUserProfile(event.username);
    //   emit(SearchUserDetailSuccess(response));
    // } catch (_) {
    //   emit(SearchUserLoadFailure());
    // }
  }

}

