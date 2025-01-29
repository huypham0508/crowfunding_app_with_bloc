part of '../../index.dart';

class ContainerForgotPw extends StatelessWidget {
  const ContainerForgotPw({
    super.key,
    required this.children,
  });

  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return BoxShadowCustom(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppColors.whitish100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
