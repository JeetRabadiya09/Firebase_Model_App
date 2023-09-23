import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void showSnackBar({
    BuildContext? context,
    String? content,
  }) {
    ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      content: Text(content ?? ""),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      dismissDirection: DismissDirection.startToEnd,
    ));
  }

  void showToastMessage({
    String? content,
  }) {
    Fluttertoast.showToast(msg: content ?? "", fontSize: 16.0);
  }
}
