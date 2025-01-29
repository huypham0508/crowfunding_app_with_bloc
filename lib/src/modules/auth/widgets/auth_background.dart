part of '../index.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        color: AppColors.whitish100,
        child: CustomPaint(
          size: Size(size.width, size.height),
          painter: _Curved(),
        ),
      ).animate().scale(
            begin: const Offset(1.3, 1.3),
            end: const Offset(1, 1),
            curve: Curves.decelerate,
            duration: 1400.milliseconds,
          ),
    );
  }
}

class _Curved extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    Paint paint = Paint();
    paint.shader = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [.01, .25],
      colors: [
        // AppColors.lightBlack,
        // AppColors.black,
        AppColors.whitish100,
        AppColors.black300,
      ],
    ).createShader(rect);

    var path = Path();
    var path2 = Path();

    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.1,
      size.width * 0.6,
      size.height * 0.1,
    );
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.1,
      size.width * 0.1,
      size.height * 0.3,
    );
    path.quadraticBezierTo(
      size.width * 0.06,
      size.height * 0.4,
      size.width * 0,
      size.height * 0.4,
    );
    path.close();

    path2.moveTo(size.width, size.height);
    path2.lineTo(size.width, size.height * 0.7);
    path2.quadraticBezierTo(
      size.width,
      size.height * .65,
      size.width,
      size.height * 0.7,
    );
    path2.quadraticBezierTo(
      size.width * .9,
      size.height * .95,
      size.width * 0.2,
      size.height * 0.97,
    );
    path2.quadraticBezierTo(
      size.width * .1,
      size.height * .98,
      size.width * 0.1,
      size.height,
    );

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class BackgroundDark extends StatelessWidget {
  const BackgroundDark({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        color: AppColors.whitish100,
        child: CustomPaint(
          size: Size(size.width, size.height),
          painter: _CurvedDark(),
        ),
      ).animate().scale(
            begin: const Offset(1.3, 1.3),
            end: const Offset(1, 1),
            curve: Curves.decelerate,
            duration: 1400.milliseconds,
          ),
    );
  }
}

class _CurvedDark extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    Paint paint = Paint();
    paint.shader = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [.01, .25],
      colors: [
        AppColors.black300,
        AppColors.black500,
        // AppColors.lightWhite,
        // AppColors.gray_6,
      ],
    ).createShader(rect);

    var path = Path();
    var path2 = Path();

    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.1,
      size.width * 0.6,
      size.height * 0.1,
    );
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.1,
      size.width * 0.1,
      size.height * 0.3,
    );
    path.quadraticBezierTo(
      size.width * 0.06,
      size.height * 0.4,
      size.width * 0,
      size.height * 0.4,
    );
    path.close();

    path2.moveTo(size.width, size.height);
    path2.lineTo(size.width, size.height * 0.7);
    path2.quadraticBezierTo(
      size.width,
      size.height * .65,
      size.width,
      size.height * 0.7,
    );
    path2.quadraticBezierTo(
      size.width * .9,
      size.height * .95,
      size.width * 0.2,
      size.height * 0.97,
    );
    path2.quadraticBezierTo(
      size.width * .1,
      size.height * .98,
      size.width * 0.1,
      size.height,
    );

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
