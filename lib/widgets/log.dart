import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                  color: Colors.black12,
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            child: Container(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 6, right: 6),
              child: Text(
                dateTime,
                textScaleFactor: 0.75,
                style: const TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
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
          elevation: 4.0,
          child: Row(
            children: [
              Flexible(
                child: Container(
                  child: Text(log),
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    top: 15.0,
                    bottom: 15.0,
                  ),
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: log));
                      },
                      splashRadius: 20.0,
                      iconSize: 20,
                      icon: Icon(Icons.copy),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
