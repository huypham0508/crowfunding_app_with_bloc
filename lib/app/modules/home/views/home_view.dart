part of '../index.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    final serverEventsManager = context.read<ServerEventsManager>();
    serverEventsManager.startListening();
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
              // IconButton(
              //   onPressed: () {
              //     showToast(
              //       context,
              //       Toast(
              //         child: CustomInfoToast(
              //           title: 'Hello, Flutter dev! ${Random().nextInt(10)}',
              //           description: 'This is a custom info toast. '
              //               'It has button confirm to close toast and distroy all',
              //         ),
              //       ),
              //       width: 420,
              //     );
              //   },
              //   icon: Icon(Icons.edit_note_rounded),
              // ),
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

class CustomInfoToast extends StatelessWidget {
  const CustomInfoToast({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whitish100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.neutral100,
            blurRadius: 6,
          )
        ],
      ),
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.info,
                  color: Colors.blue,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        overflow: TextOverflow.visible,
                        maxLines: 3,
                        style: const TextStyle(height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Toastify.of(context).removeAll();
                  },
                  child: const Text('Destroy All'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    Toastify.of(context).remove(this);
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
