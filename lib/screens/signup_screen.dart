import 'dart:io';

import 'package:todoapp/export_all.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: pageDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30.r, vertical: 30.r),
          children: [
            150.verticalSpace,
            Center(
              child: Text(
                'Create an account',
                style: headingStyle,
              ),
            ),
            30.verticalSpace,
            TextWidget(hintText: 'Email', controller: emailTextController),
            10.verticalSpace,
            TextWidget(
              hintText: 'Password',
              controller: passwordTextController,
              isPassword: true,
            ),
            10.verticalSpace,
            TextWidget(
              hintText: 'Confirm Password',
              controller: confirmPasswordTextController,
              isPassword: true,
            ),
            20.verticalSpace,
            Platform.isAndroid
                ? ButtonWidgetAndroid(buttonText: 'Sign up', onTap: () {})
                : ButtonWidgetIOS(buttonText: 'Sign up', onTap: () {}),
            40.verticalSpace,
            Center(
              child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500),
                          children: const [
                        TextSpan(text: 'Already have an account? '),
                        TextSpan(
                            text: 'Login',
                            style:
                                TextStyle(decoration: TextDecoration.underline))
                      ]))),
            ),
          ],
        ),
      ),
    );
  }
}
