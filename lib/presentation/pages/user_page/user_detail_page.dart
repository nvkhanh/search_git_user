
import 'package:github_user/configs/constants.dart';
import 'package:github_user/data/models/search_user_response.dart';
import 'package:github_user/domain/use_case.dart';
import 'package:github_user/domain/user_entity.dart';
import 'package:github_user/helper/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user/presentation/bloc/search_bloc.dart';


class UserDetailPage extends StatelessWidget {
  final UserEntity user;
  final SearchUserUseCase _searchUserUseCase;
  const UserDetailPage(this.user, this._searchUserUseCase, {super.key});

  @override
  Widget build(context) {
    return BlocProvider(
      create: (context) => SearchUserBloc(_searchUserUseCase)..add(SearchUserDetailEvent(user.login)),
      child: UserDetailView(user),
    );
  }
}

class UserDetailView extends StatelessWidget {
  final UserEntity user;
  const UserDetailView(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.buildAppBar(context, "Profile"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Style.padding20),
        child: Column(
          children: <Widget>[
            SizedBox(height: Style.padding20,),
            ClipOval(
              child: CachedNetworkImage(imageUrl: user.avatarUrl,fit: BoxFit.cover, width: 200,height: 200,),
            ),
            const SizedBox(height: 40,),
            buildRow("User name", user.login),
            BlocConsumer<SearchUserBloc, SearchUserState>(
              listener: (context, state) {

              },
              builder: (context, state) {
                if (state is SearchUserDetailSuccess) {
                  return Column(
                    children: <Widget>[
                      buildRow("Public Repos", state.user.publicRepos.toString()),
                      buildRow("Public Gits", state.user.publicGits.toString()),
                      buildRow("Followers", state.user.followers.toString()),
                      buildRow("Followings", state.user.followings.toString()),
                      // buildRow("Name", controller.userDetail.name),
                    ],
                  );
                }else if (state is SearchUserLoadInProgress) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: const CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  );
                }
                return Container();
              },
            )

          ],
        ),
      ),
    );

  }
  Widget buildRow(String leftContent, String rightContent) {
    if (rightContent.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(leftContent, style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w300)),
            Expanded(
              child: Text(rightContent,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.right,
                maxLines: 1,
              ),
            )
          ],
        ),
      );
    }else {
      return Container();
    }
  }
}
