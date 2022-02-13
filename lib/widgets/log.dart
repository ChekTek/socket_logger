import 'package:flutter/material.dart';

class Log extends StatelessWidget {
  final String log;

  const Log(
    this.log, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Text(log),
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(15.0),
        width: double.infinity,
      ),
    );
  }
}
