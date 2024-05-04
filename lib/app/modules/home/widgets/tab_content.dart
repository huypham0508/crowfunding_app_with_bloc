import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/camera_widget/camera_widget.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_move.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/models/post_model.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/widgets/image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TabContent extends StatelessWidget {
  final bool showCam;
  final bool loading;
  final bool showYourReaction;
  final List<PostsData> listData;
  final List<CameraDescription>? listCam;
  final void Function(int)? onPageChanged;

  const TabContent({
    super.key,
    required this.listData,
    this.onPageChanged,
    this.loading = false,
    this.showCam = false,
    this.listCam,
    this.showYourReaction = false,
  });

  @override
  Widget build(BuildContext context) {
    return _wrapper([
      _background(),
      if (!loading) _renderImages(),
      if (loading) _showLoading(),
    ]);
  }

  Widget _wrapper(children) {
    return FadeMoveBottomToTop(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 1, color: AppColors.whitish600),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Stack(
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _renderImages() {
    return Positioned.fill(
      child: PageView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        onPageChanged: onPageChanged,
        children: [
          // show empty
          // if (listData.isEmpty) Center(child: Text('Posts is empty!')),

          //show camera
          if (showCam && listCam!.isNotEmpty)
            TakePictureScreen(camera: listCam!.first),
          // render list posts
          ...listData.reversed.map((item) {
            return ImageWidget(
              data: item,
              showYourReaction: showYourReaction,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _showLoading() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Center(
          child: LoadingAnimationWidget.flickr(
            leftDotColor: AppColors.secondary500,
            rightDotColor: AppColors.primary600,
            size: 35,
          ),
        ),
      ),
    );
  }

  Widget _background() {
    return Positioned.fill(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.neutral100,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
