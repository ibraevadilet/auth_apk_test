import 'package:auth_apk_test/app/code/presentation/screen/code_screen.dart';
import 'package:auth_apk_test/app/pass/presentation/pass_screen.dart';
import 'package:auth_apk_test/helpers/constants/colors.dart';
import 'package:auth_apk_test/helpers/constants/text_styles.dart';
import 'package:auth_apk_test/helpers/customs/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);
  TextEditingController? numberController = TextEditingController();

  Future<String> getPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pass = prefs.getString("pass") ?? "";

    return pass;
  }

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
                child: Icon(
                  CupertinoIcons.right_chevron,
                  color: AuthApkColors.grey,
                )),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Мой номер телефона",
              style: AuthApkStyles.myPhoneNumber,
            ),
            const SizedBox(
              height: 48,
            ),
            TextFormField(
              controller: numberController,
              style: AuthApkStyles.number,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefix: Text(
                  "+996 ",
                  style: AuthApkStyles.number.copyWith(color: Colors.black),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              "Вам придет сообщение с кодом.\nНикому его не говорите.",
              style: AuthApkStyles.smsText,
            ),
            const SizedBox(
              height: 100,
            ),
            CustomButton(onTapButton: () async {
              String pass = await getPass();
              debugPrint("pass  -  $pass");
              numberController!.text.length > 8
                  ? Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => pass == ""
                              ? const CodeScreen()
                              : const PassScreen(title: "Введите пароль")))
                  : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Вы  ввели номер  не полностью")));
            })
          ],
        ),
      ),
    ));
  }
}
