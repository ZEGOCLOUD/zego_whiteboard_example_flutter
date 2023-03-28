import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:zego_express_engine/zego_express_engine.dart';
import 'package:zego_sdk_quick_start/zegocloud_token.dart';
import 'package:zego_superboard/zego_superboard.dart';

import 'constants.dart';
import 'permission.dart';
import 'call_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await createEngine();

  // ZegoSuperBoardEngine.instance.uninit();
  // ZegoSuperBoardEngine.instance
  //     .init(ZegoSuperBoardInitConfig(
  //   appID: appID,
  //   appSign: appSign,
  //   userID: "user.userID",
  //   token: ZegoTokenUtils.generateToken(appID, serverSecret, "user.userID"),
  // ));

  runApp(const MyApp());
}

Future<void> createEngine() async {

  // Get your AppID and AppSign from ZEGOCLOUD Console
  //[My Projects -> AppID] : https://console.zegocloud.com/project
  return ZegoExpressEngine.createEngineWithProfile(ZegoEngineProfile(
    appID,
    ZegoScenario.Default,
    appSign: kIsWeb ? null : appSign,
    enablePlatformView: true
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  /// Users who use the same roomID can join the same live streaming.
  final roomTextCtrl =
      TextEditingController(text: Random().nextInt(10000).toString());
  final userIDTextCtrl =
      TextEditingController(text: Random().nextInt(100000).toString());
  final userNameTextCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    requestPermission();
    userNameTextCtrl.text = 'user_${userIDTextCtrl.text}';
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      fixedSize: const Size(120, 60),
      // backgroundColor: const Color(0xff2C2F3E).withOpacity(0.6),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Please test with two or more devices'),
            const Divider(),
            TextFormField(
              controller: userIDTextCtrl,
              decoration: const InputDecoration(labelText: 'your userID'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: userNameTextCtrl,
              decoration: const InputDecoration(labelText: 'your userName'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: roomTextCtrl,
              decoration: const InputDecoration(labelText: 'roomID'),
            ),
            const SizedBox(height: 20),
            // click me to navigate to CallPage
            ElevatedButton(
              style: buttonStyle,
              child: const Text('Call Page'),
              onPressed: () => jumpToCallPage(
                context,
                localUserID: userIDTextCtrl.text,
                roomID: roomTextCtrl.text,
                localUserName: userNameTextCtrl.text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void jumpToCallPage(BuildContext context,
      {required String roomID,
      required String localUserID,
      required String localUserName}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          localUserID: localUserID,
          localUserName: localUserName,
          roomID: roomID,
        ),
      ),
    );
  }
}
