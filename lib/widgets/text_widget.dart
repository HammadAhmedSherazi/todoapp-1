import 'package:todoapp/export_all.dart';

class TextWidget extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool? isPassword;
  final bool? filled;
  final Color ? fillColor;
  final int ? maxlines;
  final String? Function(String?)? validator;
  const TextWidget(
      {super.key,
      this.hintText,
      this.filled,
      this.maxlines,
      this.fillColor,
      this.controller,
      this.isPassword,
      this.validator});

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  bool showPass = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: showPass,
      onSaved: (value) {
        widget.controller!.text = value.toString();
      },

      controller: widget.controller,
      style: TextStyle(
        fontSize: 14.sp,
        color: Colors.black,
      ),
      validator: widget.validator ??
          (value) {
            if (value!.isEmpty) {
              return "Required";
            } else {
              return null;
            }
          },
      maxLines: widget.maxlines ?? 1,
      decoration: InputDecoration(
          filled: widget.filled ?? true,
          fillColor: widget.fillColor ?? Colors.white,
          hintText: widget.hintText ?? 'Enter a text',
          hintStyle: TextStyle(
            fontSize: 14.sp,
          ),
          isCollapsed: true,
          isDense: true,
          contentPadding: EdgeInsets.all(15.r),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide.none),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide.none),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide.none),
          suffixIcon: widget.isPassword ?? false
              ? IconButton(
                  padding: EdgeInsets.zero,
                  visualDensity:
                      const VisualDensity(horizontal: -4.0, vertical: -4.0),
                  onPressed: () {
                    showPass = !showPass;
                    setState(() {});
                  },
                  icon: Icon(
                    showPass ? Icons.visibility_off : Icons.visibility,
                    size: 20.r,
                  ))
              : null),
    );
  }
}

