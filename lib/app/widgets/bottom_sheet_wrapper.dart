import 'package:flutter/material.dart';

showWepostBottomSheet(BuildContext context, Widget child) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => child,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), topRight: Radius.circular(8)),
    ),
  );
}
