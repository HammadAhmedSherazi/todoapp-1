import 'dart:io';

import 'package:todoapp/export_all.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: pageDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30.r, vertical: 30.r),
          children: [
            130.verticalSpace,
            Center(
              child: Text(
                'Sign In',
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
            20.verticalSpace,
            !Platform.isAndroid
                ? ButtonWidgetAndroid(buttonText: 'Login', onTap: () {})
                : ButtonWidgetIOS(buttonText: 'Login', onTap: () {}),
            40.verticalSpace,
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/SignUpScreen'),
                child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500),
                        children: const [
                      TextSpan(text: 'Create an acount? '),
                      TextSpan(
                          text: 'Sign Up',
                          style:
                              TextStyle(decoration: TextDecoration.underline))
                    ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}
