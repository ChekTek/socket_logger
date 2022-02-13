import 'package:flutter/material.dart';

class AlertService {
  final BuildContext _context;

  AlertService(this._context);

  showError(String title, String message) {
    showDialog(
        context: _context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  closeDialog(context);
                },
              ),
            ],
          );
        });
  }

  closeDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
