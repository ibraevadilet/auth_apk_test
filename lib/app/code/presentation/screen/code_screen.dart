import 'package:auth_apk_test/app/pass/presentation/pass_screen.dart';
import 'package:auth_apk_test/helpers/constants/colors.dart';
import 'package:auth_apk_test/helpers/constants/text_styles.dart';
import 'package:auth_apk_test/helpers/customs/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CodeScreen extends StatefulWidget {
  const CodeScreen({Key? key}) : super(key: key);

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  String codePinPut = '';

  String staticCode = "7777";
  bool isCorrect = false;
  Color line = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 57,
            ),
            RotatedBox(
                quarterTurns: 2,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    CupertinoIcons.right_chevron,
                    color: AuthApkColors.grey,
                  ),
                )),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Код из сообщения",
              style: AuthApkStyles.myPhoneNumber,
            ),
            const SizedBox(
              height: 14,
            ),
            PinCodeTextField(
              appContext: context,
              pastedTextStyle: AuthApkStyles.number,
              length: 4,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  fieldWidth: 70,
                  activeColor: line,
                  inactiveColor: line,
                  selectedColor: line),
              cursorColor: Colors.black,
              animationDuration: const Duration(milliseconds: 300),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  codePinPut = value;
                  codePinPut != staticCode && codePinPut.length == 4
                      ? line = AuthApkColors.red
                      : line = Colors.black;
                });
              },
              beforeTextPaste: (text) {
                return true;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            codePinPut != staticCode && codePinPut.length == 4
                ? Text(
                    "Неправильный код.\nПовторите пожалуйста еще раз.",
                    style: AuthApkStyles.smsText
                        .copyWith(color: AuthApkColors.red),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 100,
            ),
            CustomButton(
                textStyle: codePinPut.length != 4
                    ? AuthApkStyles.nextTextForButton
                        .copyWith(color: Colors.grey.shade200)
                    : null,
                colorButton:
                    codePinPut.length != 4 ? Colors.grey.shade400 : null,
                onTapButton: () {
                  codePinPut == staticCode
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PassScreen(
                                    title: "Задайте пароль",
                                  )))
                      : ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Вы  ввели неправильный код")));
                })
          ],
        ),
      ),
    ));
  }
}
