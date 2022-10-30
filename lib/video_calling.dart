import 'package:easy_agora_uikit/easy_agora_uikit.dart';
import 'package:flutter/material.dart';

class BestService extends StatelessWidget {
  const BestService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VideoCall(
      serverLink: "https://agora-node-tokenserver.davidcaleb.repl.co/access_token?channelName",
      channelName: "test",
      appID: "63a29f76b5704dd0bf01316fc9f8f736",
      floatingLayoutHeight: 300,
      floatingLayoutWidth: 300,
    );
  }
}
