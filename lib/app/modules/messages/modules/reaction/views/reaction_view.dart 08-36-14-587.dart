import 'package:crowfunding_app_with_bloc/app/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/global_widget/zoom_tap_animation.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/modules/reaction/bloc/reaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReactionView extends StatelessWidget {
  final String? idPost;
  const ReactionView({super.key, required this.idPost});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ReactionBloc(
          reactionRepository: ReactionRepository(
            graphQLClient: context.read<GraphQlAPIClient>(),
          ),
        )..add(InitialReactionEvent());
      },
      child: BlocBuilder<ReactionBloc, ReactionState>(
        builder: (context, state) {
          return FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ...state.reactions.map(
                  (item) {
                    return Reaction(
                      image: '${ConfigGraphQl.baseUrl}${item.imageURL}',
                      onTap: (focus) {
                        if (idPost != null) {
                          if (focus) {
                            context.read<ReactionBloc>().add(
                                  DecrementReactionEvent(
                                    idPost: idPost!,
                                    reactName: item.name ?? '',
                                  ),
                                );
                          } else {
                            context.read<ReactionBloc>().add(
                                  IncrementReactionEvent(
                                    idPost: idPost!,
                                    reactName: item.name ?? '',
                                  ),
                                );
                          }
                        }
                      },
                    );
                  },
                ).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Reaction extends StatefulWidget {
  final String image;
  final Function(bool focus)? onTap;
  const Reaction({
    super.key,
    required this.image,
    this.onTap,
  });

  @override
  State<Reaction> createState() => _ReactionState();
}

class _ReactionState extends State<Reaction> {
  bool focus = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 20.ms,
      curve: Curves.bounceIn,
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        border: Border(
          top: BorderSide(
            width: 20,
            color: focus ? AppColors.whitish100 : AppColors.transparent,
          ),
        ),
      ),
      child: ZoomTapAnimation(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!(focus);
          }
          setState(() {
            focus = !focus;
          });
        },
        child: Image.network(
          widget.image,
          fit: BoxFit.fitWidth,
          errorBuilder: (context, error, stackTrace) {
            return SizedBox();
          },
        ),
      ),
    );
  }
}
