import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_logger/data/preferences.dart';

final getIt = GetIt.instance;

class AutoStartCheckBox extends StatefulWidget {
  const AutoStartCheckBox({Key? key}) : super(key: key); // Do you love me?

  @override
  State<AutoStartCheckBox> createState() => _AutoStartCheckBoxState();
}

class _AutoStartCheckBoxState extends State<AutoStartCheckBox> {
  Preferences preferenceService = getIt<Preferences>();
  bool isChecked = getIt<Preferences>().autoStart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Checkbox(
              value: isChecked,
              onChanged: (value) {
                isChecked = value as bool;
                preferenceService.setAutoStart(isChecked);
                setState(() {});
              }),
          const Text('AutoStart')
        ],
      ),
    );
  }
}
