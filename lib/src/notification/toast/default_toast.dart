import 'package:crowfunding_app_with_bloc/src/notification/toast/toastify.dart';
import 'package:flutter/material.dart';

class DefaultToast extends StatelessWidget {
  const DefaultToast({
    Key? key,
    required this.toast,
  }) : super(key: key);

  final Toast toast;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16) - const EdgeInsets.only(right: 16),
        child: Row(
          children: [
            if (toast.leading != null) ...[
              toast.leading!,
              const SizedBox(width: 16),
            ] else
              const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    toast.title!,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    toast.description!,
                    overflow: TextOverflow.visible,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                Toastify.of(context).remove(this);
              },
              icon: const Icon(Icons.close),
              splashRadius: 24,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

class DefaultToastTransition extends StatelessWidget {
  const DefaultToastTransition({
    Key? key,
    required this.animation,
    required this.child,
  }) : super(key: key);
  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
