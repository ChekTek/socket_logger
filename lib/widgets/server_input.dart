import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_logger/data/preferences.dart';

final getIt = GetIt.instance;

class ServerInput extends StatefulWidget {
  ServerInput({Key? key}) : super(key: key);
  final controller = TextEditingController(text: getIt<Preferences>().host);

  @override
  State<ServerInput> createState() => _ServerInputState();
}

class _ServerInputState extends State<ServerInput> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: TextField(
          textAlignVertical: TextAlignVertical.bottom,
          controller: widget.controller,
          decoration: const InputDecoration(hintText: 'Enter socket'),
        ),
      ),
    );
  }
}
