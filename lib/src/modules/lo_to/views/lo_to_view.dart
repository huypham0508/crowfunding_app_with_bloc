import 'package:crowfunding_app_with_bloc/src/constants/app_colors.dart';
import 'package:crowfunding_app_with_bloc/src/modules/lo_to/bloc/lo_to_bloc.dart';
import 'package:crowfunding_app_with_bloc/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoToView extends StatefulWidget {
  const LoToView({super.key});

  @override
  State<LoToView> createState() => _LoToViewState();
}

class _LoToViewState extends State<LoToView> {
  late LoToBloc loToBloc;
  final TextEditingController _userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loToBloc = BlocProvider.of<LoToBloc>(context)..add(InitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoToBloc, LotoState>(
      listenWhen: (previous, current) {
        bool conditionListen = (previous.status != current.status) ||
            (current.status == LotoStatus.backDialog);
        if (conditionListen) {
          return true;
        } else {
          return false;
        }
      },
      listener: (context, state) {
        switch (state.status) {
          case LotoStatus.loading:
            showDialog(
                context: context,
                barrierColor: AppColors.black300.withOpacity(0.2),
                builder: (context) => Utils.loading(loading: 'Loading...'));
            break;
          case LotoStatus.userNameFailure:
            showDialog(
              context: context,
              builder: (context) => enterUserName(),
            );
            break;
          case LotoStatus.backDialog:
            context.pop();
            break;
          default:
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: content(),
        drawer: drawer(),
      ),
    );
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: BlocBuilder<LoToBloc, LotoState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...[
                  const Text(
                    'Không đánh lô tô, đời không nể',
                    style: TextStyle(
                      color: AppColors.black100,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    state.count.toString(),
                    style: const TextStyle(
                      color: AppColors.black500,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: BlocBuilder<LoToBloc, LotoState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              ...[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: AppColors.black100,
                  ),
                  child: Text(
                    'Tên của bạn là: \n${state.userName}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
              ...state.listUsers.map(
                (user) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    user,
                    style: const TextStyle(
                      color: AppColors.black100,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget enterUserName() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.whitish100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Những người có máu cờ bạc cần có 1 cái tên...',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.black100,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              child: TextField(
                controller: _userNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.black100),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              child: GestureDetector(
                onTap: () => loToBloc.add(
                  UpdateUserName(userName: _userNameController.text),
                ),
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.black100,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Hoàn thành đặt tên',
                    style: TextStyle(
                      color: AppColors.whitish100,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
