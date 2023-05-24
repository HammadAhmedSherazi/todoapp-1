//GLOBAL PAGE DECORATION

import '../export_all.dart';

BoxDecoration pageDecoration = const BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xff12C2E9), Color(0xffF64F59)]));

TextStyle headingStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 22.sp,
    shadows: [Shadow(color: Colors.black.withOpacity(0.5))]);
