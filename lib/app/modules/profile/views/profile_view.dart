import 'package:crowfunding_app_with_bloc/app/constants/index.dart';

import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_scale.dart';
import 'package:crowfunding_app_with_bloc/app/global_widget/avatar_custom.dart';
import 'package:crowfunding_app_with_bloc/app/global_widget/draggable_scrollable_sheet.dart';
import 'package:crowfunding_app_with_bloc/app/modules/profile/bloc/profile_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => ProfileBloc(
        localDataSource: context.read<LocalDataSource>(),
      )..add(InitialProfileEvent()),
      child:
          BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
        switch (state.status) {
          case ProfileStatus.loading:
            showDialog(
              context: context,
              barrierColor: AppColors.black300.withOpacity(0.2),
              builder: (context) => Utils.loading(loading: 'Loading...'),
            );
            break;
          case ProfileStatus.backModel:
            context.pop();
            break;
          default:
        }
      }, builder: (context, state) {
        ProfileBloc profileBloc = context.read<ProfileBloc>();
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text("Profile"),
            centerTitle: true,
            backgroundColor: AppColors.whitish100,
          ),
          body: Container(
            color: AppColors.whitish100,
            child: Column(
              children: [
                Container(
                  height: height * 0.1,
                  // color: AppColors.black100,
                ),
                Expanded(
                  child: KeyboardVisibilityBuilder(
                      builder: (context, isKeyboardVisible) {
                    return Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Transform.translate(
                            offset: Offset(
                              0,
                              isKeyboardVisible ? 0 : -(height * 0.20 / 3 * 2),
                            ),
                            child: Center(
                              child: state.status == ProfileStatus.loading
                                  ? SizedBox()
                                  : Column(
                                      children: [
                                        if (!isKeyboardVisible)
                                          AvatarCustom(
                                            translate: false,
                                            image: state.avatar,
                                            widthAvatarBox: height * 0.20,
                                          ),
                                        const SizedBox(height: 15),
                                        _inputUserName(state),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                        if (!isKeyboardVisible)
                          DraggableScrollableSheetCustom(
                            title: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Text(
                                  'Choose Avatar',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            ),
                            builder: (controller) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GridView.count(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(20),
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: width / 3 > 120 ? 3 : 2,
                                    children: [
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                            image: AppImages.imAvatar,
                                          ),
                                        ),
                                      ),
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar2,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                            image: AppImages.imAvatar2,
                                          ),
                                        ),
                                      ),
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar3,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                            image: AppImages.imAvatar3,
                                          ),
                                        ),
                                      ),
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar4,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                            image: AppImages.imAvatar4,
                                          ),
                                        ),
                                      ),
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar5,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                            image: AppImages.imAvatar5,
                                          ),
                                        ),
                                      ),
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar6,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                            image: AppImages.imAvatar6,
                                          ),
                                        ),
                                      ),
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar7,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                            image: AppImages.imAvatar7,
                                          ),
                                        ),
                                      ),
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar8,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                            image: AppImages.imAvatar8,
                                          ),
                                        ),
                                      ),
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar9,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                            image: AppImages.imAvatar9,
                                          ),
                                        ),
                                      ),
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar10,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                              image: AppImages.imAvatar10),
                                        ),
                                      ),
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar11,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                              image: AppImages.imAvatar11),
                                        ),
                                      ),
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar12,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                              image: AppImages.imAvatar12),
                                        ),
                                      ),
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar13,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                              image: AppImages.imAvatar13),
                                        ),
                                      ),
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar14,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                              image: AppImages.imAvatar14),
                                        ),
                                      ),
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar15,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                              image: AppImages.imAvatar15),
                                        ),
                                      ),
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar16,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                              image: AppImages.imAvatar16),
                                        ),
                                      ),
                                      ChooseAvatarItem(
                                        imageUrl: AppImages.imAvatar17,
                                        onTap: () => profileBloc.add(
                                          ChangeProfileImageEvent(
                                              image: AppImages.imAvatar17),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                      ],
                    );
                  }),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _inputUserName(ProfileState state) {
    return Container(
      height: 65,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.whitish100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.black100,
        ),
      ),
      child: Center(
        child: TextField(
          // onTap: onFocusChange,
          // focusNode: focusNode,
          controller: state.userNameController,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.left,
          cursorColor: AppColors.black500,
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.black500,
          ),
          decoration: const InputDecoration(
            isCollapsed: true,
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            hintStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.neutral400,
            ),
            hintText: "Your username",
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.neutral400,
            ),
          ),
        ),
      ),
    );
  }
}

class ChooseAvatarItem extends StatelessWidget {
  const ChooseAvatarItem({
    super.key,
    required this.imageUrl,
    this.onTap,
  });

  final String imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.whitish100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeScale(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
