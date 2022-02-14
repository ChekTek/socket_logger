import 'package:flutter/material.dart';

class AlertService {
  final GlobalKey<NavigatorState> _navigatorKey;

  AlertService(this._navigatorKey);

  showError(String title, String message) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final context = _navigatorKey.currentContext;
      if (context != null) {
        showDialog(
            context: context,
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
    });
  }

  closeDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
