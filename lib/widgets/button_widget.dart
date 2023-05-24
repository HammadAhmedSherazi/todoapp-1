import 'package:flutter/cupertino.dart';
import 'package:todoapp/export_all.dart';

//ANDROID BUTTON
class ButtonWidgetAndroid extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const ButtonWidgetAndroid(
      {super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.all(15.r)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(30.r),
                    right: Radius.circular(30.r)))),
            backgroundColor: const MaterialStatePropertyAll(
                Color.fromARGB(209, 119, 51, 48))),
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600),
        ));
  }
}

//IOS BUTTON
class ButtonWidgetIOS extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const ButtonWidgetIOS(
      {super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        onPressed: onTap,
        padding: EdgeInsets.all(15.r),
        color: const Color.fromARGB(209, 119, 51, 48),
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(30.r), right: Radius.circular(30.r)),
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600),
        ));
  }
}
