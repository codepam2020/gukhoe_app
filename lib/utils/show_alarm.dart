import 'package:flutter/material.dart';

void showAlarm(context, String title, String content) {
  showDialog(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(title: Text(title), content: Text(content), actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('확인'))
          ]));
}
