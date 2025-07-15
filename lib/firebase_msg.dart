import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMsg{
  final msgService = FirebaseMessaging.instance;
  var token;

  initFCM() async {
    await msgService.requestPermission();
    token = await msgService.getToken();
    print('Firebase msg Token = $token');
    FirebaseMessaging.onBackgroundMessage(handleNotification);
    FirebaseMessaging.onMessage.listen(handleNotification);
  }
}

Future<void> handleNotification(RemoteMessage msg) async {

}