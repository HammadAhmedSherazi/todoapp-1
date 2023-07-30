import 'package:flutter/cupertino.dart';
import 'package:todoapp/export_all.dart';

//ANDROID BUTTON
class ButtonWidgetAndroid extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final double width;
  const ButtonWidgetAndroid(
      {super.key, required this.buttonText, required this.onTap, required this.width});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size.fromWidth(width)),
            elevation: const MaterialStatePropertyAll(10.0),
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
  final double  width;
  const ButtonWidgetIOS(
      {super.key, required this.buttonText, required this.onTap,required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: CupertinoButton(
          onPressed: onTap,
          minSize: width,
          alignment: Alignment.center,
          // padding: EdgeInsets.all(15.r),
          color: const Color.fromARGB(209, 119, 51, 48),
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(30.r), right: Radius.circular(30.r)),
          child: Text(
            buttonText,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600),
          )),
    );
  }
}
