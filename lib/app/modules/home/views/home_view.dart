import 'package:camera/camera.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/data/repository/graphql/post_repository.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/camera/camera_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/views/scaffold_custom_view.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/box_shadow_custom.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/bloc/home_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/modules/friend/views/friend_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/widgets/tab_bar_custom.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/widgets/tab_content.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CameraDescription> _cameraDesc = context.read<CameraBloc>().cameras;
    const List<String> tabs = ['You', 'Friends', 'All'];

    return ScaffoldCustom(
      drawer: FriendView(),
      body: BlocProvider(
        create: (context) {
          return HomeBloc(
            postRepository: PostRepository(
              graphQLClient: context.read<GraphQlAPIClient>(),
            ),
          )..add(InitialHomeEvent());
        },
        child: BoxShadowCustom(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GlobalStyles.sizedBoxHeight_10,
              GlobalStyles.sizedBoxHeight_10,
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  HomeBloc homeBloc = context.read<HomeBloc>();
                  return TabBarCustom(
                    controller: state.pageController,
                    onPageChanged: (index) {
                      homeBloc.add(
                        ChangeTabHomeEvent(index: index, gesture: true),
                      );
                    },
                    tabs: tabs.asMap().entries.map(
                      (entry) {
                        int idx = entry.key;
                        String val = entry.value;
                        return TabItem(
                          tabName: val,
                          active: state.tabIndex == idx,
                          onTap: () => homeBloc.add(JumpToPage(index: idx)),
                        );
                      },
                    ).toList(),
                    tabsContents: [
                      //your posts
                      TabContent(
                        showYourReaction: true,
                        loading: state.loadingYourPosts,
                        listData: state.yourPosts,
                        onPageChanged: (index) {
                          if (index == state.yourPosts.length - 3) {
                            homeBloc.add(GetYourPosts());
                          }
                        },
                      ),
                      //posts your friends
                      TabContent(
                        loading: state.loadingPostsYourFriends,
                        listData: state.postsYourFriends,
                        onPageChanged: (index) {
                          if (index == state.postsYourFriends.length - 3) {
                            homeBloc.add(GetPostsYourFriend());
                          }
                        },
                      ),
                      //posts all
                      TabContent(
                        loading: state.loadingAllPosts,
                        listData: state.allPosts,
                        showCam: true,
                        listCam: _cameraDesc,
                        onPageChanged: (index) {
                          if (index == state.allPosts.length - 3) {
                            homeBloc.add(GetAllPosts());
                          }
                        },
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
