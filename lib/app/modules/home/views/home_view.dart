import 'package:camera/camera.dart';
import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/camera/camera_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/camera_widget/camera_widget.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/views/scaffold_custom_view.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_move.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/box_shadow_custom.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<Widget> listNewFeed = [
  ImageWidget(),
  ImageWidget(),
  ImageWidget(),
  ImageWidget(),
  ImageWidget(),
  ImageWidget(),
  ImageWidget(),
  ImageWidget(),
];

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late PageController _pageViewController;

  @override
  void initState() {
    _pageViewController = PageController(initialPage: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CameraDescription> _cameraDesc = context.read<CameraBloc>().cameras;
    return ScaffoldCustom(
      body: BoxShadowCustom(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GlobalStyles.sizedBoxHeight_10,
            GlobalStyles.sizedBoxHeight_10,
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    right: 10,
                    left: 10,
                    bottom: 20,
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: FadeMoveTopToBottom(
                            child: PageView(
                              scrollDirection: Axis.vertical,
                              // controller: _pageViewController,
                              onPageChanged: (index) {
                                if (index == listNewFeed.length - 3) {
                                  List<Widget> listNext = [
                                    ImageWidget(),
                                    ImageWidget(),
                                    ImageWidget(),
                                    ImageWidget(),
                                    ImageWidget(),
                                    ImageWidget(),
                                    ImageWidget(),
                                    ImageWidget(),
                                  ];
                                  listNewFeed = [...listNewFeed, ...listNext];
                                  setState(() {});
                                }
                              },
                              children: listNewFeed,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: FadeMoveTopToBottom(
                            child: PageView(
                              scrollDirection: Axis.vertical,
                              controller: _pageViewController,
                              onPageChanged: (index) {
                                if (index == listNewFeed.length - 3) {
                                  debugPrint("haha");
                                  List<Widget> listNext = [
                                    ImageWidget(),
                                    ImageWidget(),
                                    ImageWidget(),
                                    ImageWidget(),
                                    ImageWidget(),
                                    ImageWidget(),
                                    ImageWidget(),
                                    ImageWidget(),
                                  ];
                                  listNewFeed = [...listNewFeed, ...listNext];
                                  setState(() {});
                                }
                              },
                              children: [
                                if (_cameraDesc.isNotEmpty)
                                  TakePictureScreen(camera: _cameraDesc.first),
                                ...listNewFeed
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Friends',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whitish100,
                          ),
                        ),
                        GlobalStyles.sizedBoxWidth,
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.whitish100,
                                width: 3,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: Text(
                            'All',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whitish100,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
