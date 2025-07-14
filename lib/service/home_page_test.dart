import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seller/service/notification_service.dart';
import 'package:http/http.dart' as http;

import 'provider/access_token_firebase.dart';

class HomePageTest extends StatefulWidget {
  const HomePageTest({super.key});

  @override
  State<HomePageTest> createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> {
  NotificationService service = NotificationService();

  @override
  void initState() {
    // TODO: implement initState
    // ✅ Local notification initialization (must be first)
    // service.initLocalNotifications();

    // ✅ Notification permission
    service.requestNotificationPermission();
    //
    service.setUpInteractMessage(context);
    // ✅ Firebase listener
    service.firebaseInit(context);

    // ✅ Show device token
    service.getDeviceToken().then((value) {
      print("🔑 Device Token: $value");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("flutter Notification")),
        body: TextButton(
            onPressed: () {
              // send notification from one device to another
              service
                  .getDeviceToken()
                  .then((value) async {
                final accessToken = await AccessTokenFirebase.getAccessToken();

                final url = Uri.parse(
                    'https://fcm.googleapis.com/v1/projects/grocery-app-4ca36/messages:send'
                );
 var tokens = "fveCyAqITACzXupXOxbA_2:APA91bGPBxhN3IUGTDzzONuj0GckMtB2jBDrpv9o1oAeOEC6QQs47SWcjFe0VizTZRGZ9o71wqIwEr_TzKSj6oRtjjSGeqLL1TxKULw7qEkX6Cu9GokecJ8";
                final body = {
                  "message": {
                    "token": tokens,
                    "notification": {
                      "title": "FCM v1 Title",
                      "body": "FCM v1 Body",
                    },
                    'data':{
                      'type':'message',
                      'id':'jasim12345'
                    }
                  }
                };

                final response = await http.post(
                  url,
                  headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer $accessToken',
                  },
                  body: jsonEncode(body),
                );

                print('FCM v1 Status: ${response.statusCode}');
                print('FCM v1 Body: ${response.body}');
              });
              },
            child: Text('Send Notifications')));
  }
}
