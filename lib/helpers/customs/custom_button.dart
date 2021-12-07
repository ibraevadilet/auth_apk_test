import 'package:auth_apk_test/helpers/constants/colors.dart';
import 'package:auth_apk_test/helpers/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final Color? colorButton;
  final Function() onTapButton;
  final TextStyle? textStyle;
  const CustomButton(
      {Key? key,
      this.width,
      this.colorButton,
      required this.onTapButton,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapButton,
      child: Container(
        alignment: Alignment.center,
        height: 48,
        width: MediaQuery.of(context).size.width - 56,
        decoration: BoxDecoration(
          color: colorButton ?? AuthApkColors.blueRigth,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          "Продолжить",
          style:
              textStyle != null ? textStyle! : AuthApkStyles.nextTextForButton,
        ),
      ),
    );
  }
}
