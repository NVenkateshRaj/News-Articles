import 'package:flutter/material.dart';
import 'package:newsarticle/constants/colors.dart';

class CommonLoadingScreen extends StatelessWidget {
  final bool absorbing;
  final Widget child;
  final bool eligible;
  const CommonLoadingScreen(
      {super.key,
      required this.absorbing,
      required this.child,
      this.eligible = false});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AbsorbPointer(absorbing: absorbing || eligible, child: child),
        absorbing
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColor.primary,
              ))
            : Container(),
      ],
    );
  }
}
