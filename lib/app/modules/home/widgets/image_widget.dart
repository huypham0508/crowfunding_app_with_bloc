import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/models/post_model.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/modules/reaction/views/reaction_view.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/widgets/your_reaction.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final PostsData data;
  final bool showYourReaction;
  const ImageWidget({
    super.key,
    required this.data,
    this.showYourReaction = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        children: [
          _renderImage(),
          _renderInformation(),
          if (!showYourReaction) _renderReactions(),
          if (showYourReaction) _renderYourReactions(),
        ],
      ),
    );
  }

  Positioned _renderImage() {
    return Positioned.fill(
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            data.imageUrl ?? AppImages.fakeImageNetwork,
            fit: BoxFit.cover,
            width: double.maxFinite,
            height: double.maxFinite,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: AppColors.black200,
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }

  Positioned _renderInformation() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 80,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (data.user != null) _showUsername(data.user!.userName ?? ""),
            GlobalStyles.sizedBoxHeight_5,
            _showDesc(data.description ?? ""),
          ],
        ),
      ),
    );
  }

  Positioned _renderReactions() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        child: ReactionView(idPost: data.id),
      ),
    );
  }

  Positioned _renderYourReactions() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        child: YourReaction(reactions: data.reactions ?? []),
      ),
    );
  }

  Text _showDesc(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: AppColors.whitish600,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(0.2, 0.2),
            blurRadius: 0.0,
            color: AppColors.black100,
          ),
        ],
      ),
    );
  }

  Text _showUsername(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.whitish100,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(0.2, 0.2),
            blurRadius: 0.0,
            color: AppColors.black100,
          ),
        ],
      ),
    );
  }
}
