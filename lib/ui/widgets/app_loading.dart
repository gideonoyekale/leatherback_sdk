import 'package:flutter/material.dart';
import 'package:leatherback_sdk/core/cores.dart';
import 'package:leatherback_sdk/ui/widgets/base_dialog_screen.dart';
import 'package:lottie/lottie.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseDialogScreen(
      showClose: false,
      child: Center(
        child: Lottie.asset(
          Assets.loader,
          repeat: true,
          fit: BoxFit.fitWidth,
          height: MediaQuery.of(context).size.height * 0.3,
          package: Constants.packageName,
        ),
      ),
    );
  }
}
