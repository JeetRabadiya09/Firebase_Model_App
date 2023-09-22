import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final int? minAndMaxLine;

  AppTextField({
    Key? key,
    this.controller,
    required this.hintText,
    required this.minAndMaxLine,
  }) : super(key: key);
  final TextEditingController referralCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return TextField(
      textAlignVertical: TextAlignVertical.bottom,
      keyboardType: TextInputType.name,
      controller: controller,
      minLines: minAndMaxLine,
      maxLines: minAndMaxLine,
      autofocus: true,
      style: TextStyle(
        color: CupertinoColors.black,
        fontWeight: FontWeight.w400,
        fontSize: height / 60,
        fontStyle: FontStyle.normal,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: CupertinoColors.black),
          borderRadius: BorderRadius.all(
            Radius.circular(width / 150),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(
            Radius.circular(width / 150),
          ),
        ),
        hintText: hintText ?? "",
        filled: true,
        fillColor: const Color(0xffFFFFFF),
      ),
    );
  }
}
