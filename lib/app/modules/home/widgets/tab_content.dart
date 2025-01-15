part of '../index.dart';

class TabContent extends StatefulWidget {
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
  State<TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<TabContent>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _wrapper([
      _background(),
      if (!widget.loading && widget.listData.isEmpty)
        Center(child: Text('Not found!!!')),
      if (!widget.loading) _renderImages(),
      if (widget.loading) _showLoading(),
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
        onPageChanged: widget.onPageChanged,
        children: [
          // show empty
          // if (listData.isEmpty) Center(child: Text('Posts is empty!')),

          //show camera
          if (widget.showCam && widget.listCam!.isNotEmpty)
            TakePictureScreen(camera: widget.listCam!.first),
          // render list posts
          ...widget.listData.reversed.map((item) {
            return ImageWidget(
              data: item,
              showYourReaction: widget.showYourReaction,
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
          color: AppColors.whitish100,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
