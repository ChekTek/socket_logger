import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/socket_service.dart';
import 'control_bar.dart';
import 'log_list.dart';

final getIt = GetIt.instance;

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            MessagePanel(),
            Expanded(
              child: Card(
                child: Column(
                  children: const [
                    ControlBar(),
                    LogList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagePanel extends StatelessWidget {
  final controller = TextEditingController();
  SocketService socketService = getIt<SocketService>();
  ScrollController _controller = new ScrollController();

  MessagePanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4),
      child: SizedBox(
        width: 400,
        child: Card(
          child: ListView(
            padding: EdgeInsets.all(20),
            controller: _controller,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: MaterialButton(
                  minWidth: 250,
                  child: const Text('Send'),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => {socketService.send(controller.text)},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
