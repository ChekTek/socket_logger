import 'package:flutter/material.dart';

import 'control_bar.dart';
import 'log_list.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          ControlBar(),
          LogList(),
        ],
      ),
    );
  }
}
