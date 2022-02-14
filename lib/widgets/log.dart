import 'package:flutter/material.dart';

class Log extends StatelessWidget {
  final String log;
  final String dateTime;

  const Log(
    this.log,
    this.dateTime, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.only(right: 16.0),
          child: Container(
            margin: const EdgeInsets.only(top: 16.0),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(1, 1),
                ),
              ],
              color: Colors.grey[400],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                dateTime,
                textScaleFactor: 0.75,
                style: const TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0),
          elevation: 3.0,
          child: Column(
            children: [
              Container(
                child: Text(log),
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.all(15.0),
                width: double.infinity,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
