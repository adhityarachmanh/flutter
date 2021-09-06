import 'package:flutter/material.dart';

Future<DateTime?> picketDate(
    {required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate}) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate);
  return picked;
}
