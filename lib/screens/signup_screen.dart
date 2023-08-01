import 'dart:io';

import 'package:todoapp/export_all.dart';
import 'package:todoapp/services/api_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static final formKey = GlobalKey<FormState>();

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailTextController =
      TextEditingController();

  final TextEditingController passwordTextController =
      TextEditingController();

  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  final TextEditingController userNameTextController =
      TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: pageDecoration,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Form(
          key: SignUpScreen.formKey,
          child: ListView(
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
              TextWidget(hintText: 'Username', controller: userNameTextController),
              10.verticalSpace,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  } else if (value != passwordTextController.text) {
                    return "Please Enter Correct Password";
                  } else {
                    return null;
                  }
                },
                isPassword: true,
              ),
              20.verticalSpace,
              Platform.isAndroid
                  ? ButtonWidgetAndroid(
                      buttonText: 'Sign up',
                      width: 362.w,
                      onTap: () async {
                        if (SignUpScreen.formKey.currentState!.validate()) {
                          Map<String, String> sendData = {
                            "email": emailTextController.text.trim(),
                            "password": passwordTextController.text,
                            "name" : userNameTextController.text.trim()
                          };
                          await ApiService.registrationApi(sendData, context);
                        }
                      })
                  : ButtonWidgetIOS(buttonText: 'Sign up', onTap: () async {
                     if (SignUpScreen.formKey.currentState!.validate()) {
                          Map<String, String> sendData = {
                            "email": emailTextController.text.trim(),
                            "password": passwordTextController.text,
                            "name" : userNameTextController.text.trim()
                          };
                          await ApiService.registrationApi(sendData, context);
                        }
                  }, width: 362.w,),
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
                              style: TextStyle(
                                  decoration: TextDecoration.underline))
                        ]))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
