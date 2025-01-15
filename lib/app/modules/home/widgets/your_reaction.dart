part of '../index.dart';

class YourReaction extends StatelessWidget {
  final List<ReactionModel> reactions;
  const YourReaction({super.key, required this.reactions});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ...reactions.map(
            (item) {
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.whitish100,
                  borderRadius: BorderRadius.circular(500),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Image.network(
                        '${ConfigGraphQl.baseUrl}${item.imageURL}',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Text(
                      item.count.toString(),
                      style: TextStyle(color: AppColors.black100),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
