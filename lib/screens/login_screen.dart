import 'dart:io';

import 'package:todoapp/export_all.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTextController = TextEditingController();
  static final formKey = GlobalKey<FormState>();
  final TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: pageDecoration,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Form(
          key: formKey,
          child: ListView(
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
              Platform.isAndroid
                  ? ButtonWidgetAndroid(
                      buttonText: 'Login',
                      width: 362.w,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          Map<String, String> sendReq = {
                            "email": emailTextController.text.trim(),
                            "password": passwordTextController.text
                          };
                          ApiService.loginApi(sendReq, context);
                        }
                      })
                  : ButtonWidgetIOS(width: 362.w,buttonText: 'Login', onTap: () {
                     if (formKey.currentState!.validate()) {
                          Map<String, String> sendReq = {
                            "email": emailTextController.text.trim(),
                            "password": passwordTextController.text
                          };
                          ApiService.loginApi(sendReq, context);
                        }
                  }),
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
      ),
    );
  }
}
