

import 'dart:math';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  UserEntity({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.score,
    required this.publicRepos,
    required this.publicGits,
    required this.followers,
    required this.followings,
    required this.name
  });

  String login;
  int id;
  String avatarUrl;
  double? score;
  int publicRepos;
  int publicGits;
  int followers;
  int followings;
  String name;

  @override
  // TODO: implement props
  List<Object?> get props => [
    login,
    id,
    avatarUrl,
    score,
    publicRepos,
    publicGits,
    followers,
    followings,
    name,
  ];


}