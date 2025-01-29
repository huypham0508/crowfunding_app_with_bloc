part of '../index.dart';

class InputAuthCustom extends StatelessWidget {
  final TextEditingController textController;
  final String hinText;
  final String? title;
  final bool obscureText;
  final EdgeInsets margin;
  final Function(String value)? onChange;
  final Function(String value)? onSubmitted;
  const InputAuthCustom({
    super.key,
    this.title,
    required this.textController,
    required this.hinText,
    this.obscureText = false,
    this.margin = const EdgeInsets.only(left: 16.0, right: 32.0),
    this.onChange,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return FadeScale(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title ?? '',
              style: TextStyle(fontSize: 14, color: AppColors.black100),
            ),
          const SizedBox(height: 5),
          ContainerInputCustom(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: textController,
                cursorColor: Colors.black,
                obscureText: obscureText,
                onChanged: onChange,
                onFieldSubmitted: onSubmitted,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: AppColors.black200,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hinText,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: AppColors.neutral100,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
