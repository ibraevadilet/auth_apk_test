import 'package:auth_apk_test/app/home/presentation/screen/home_screen.dart';
import 'package:auth_apk_test/helpers/constants/colors.dart';
import 'package:auth_apk_test/helpers/constants/text_styles.dart';
import 'package:auth_apk_test/helpers/customs/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PassScreen extends StatefulWidget {
  final String title;
  const PassScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<PassScreen> createState() => _PassScreenState();
}

class _PassScreenState extends State<PassScreen> {
  Future<String> getPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pass = prefs.getString("pass") ?? "";

    return pass;
  }

  String passInput = '';
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
            Text(
              widget.title,
              style: AuthApkStyles.myPhoneNumber,
            ),
            const SizedBox(
              height: 14,
            ),
            PinCodeTextField(
              appContext: context,
              pastedTextStyle: AuthApkStyles.number,
              length: 4,
              obscureText: true,
              obscuringCharacter: '*',
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
                  passInput = value;
                });
              },
              beforeTextPaste: (text) {
                return true;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            CustomButton(
                textStyle: passInput.length != 4
                    ? AuthApkStyles.nextTextForButton
                        .copyWith(color: Colors.grey.shade200)
                    : null,
                colorButton:
                    passInput.length != 4 ? Colors.grey.shade400 : null,
                onTapButton: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  passInput.length == 4 && widget.title == "Задайте пароль"
                      ? preferences.setString("pass", passInput)
                      : null;
                  if (widget.title == "Введите пароль" &&
                      passInput == await getPass()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                  pass: passInput,
                                )));
                  } else if (widget.title == "Введите пароль" &&
                      passInput != await getPass()) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Вы  ввели неправильный пароль")));
                  } else if (widget.title == "Задайте пароль") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                  pass: passInput,
                                )));
                  }
                })
          ],
        ),
      ),
    ));
  }
}
