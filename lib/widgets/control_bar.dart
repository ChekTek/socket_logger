import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_logger/data/preferences.dart';
import 'package:socket_logger/services/socket_service.dart';
import 'package:socket_logger/widgets/auto_start_check_box.dart';
import 'package:socket_logger/widgets/clear_button.dart';
import 'package:socket_logger/widgets/server_button.dart';
import 'package:socket_logger/widgets/server_input.dart';

final getIt = GetIt.instance;

class ControlBar extends StatefulWidget {
  const ControlBar({
    Key? key,
  }) : super(key: key);

  @override
  State<ControlBar> createState() => _ControlBarState();
}

class _ControlBarState extends State<ControlBar> {
  final serverInput = ServerInput();
  final autoStartCheckBox = const AutoStartCheckBox();
  final clearButton = const ClearButton();
  late ServerButton serverButton;
  SocketService socketService = getIt<SocketService>();
  Preferences preferenceService = getIt<Preferences>();

  @override
  void initState() {
    super.initState();

    if (preferenceService.autoStart) {
      socketService.connect(int.parse(serverInput.controller.text));
    }

    serverInput.controller.addListener(() {
      preferenceService.setHost(int.parse(serverInput.controller.text));
    });

    serverButton = ServerButton(serverStringController: serverInput.controller);
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        serverButton,
        serverInput,
        autoStartCheckBox,
        clearButton,
      ],
    );
  }
}
