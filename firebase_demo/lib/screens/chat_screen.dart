import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/widgets/chat/messages.dart';
import 'package:firebase_demo/widgets/chat/new_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('A bg message just showed up: ${message.messageId}');
}

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();

    final fbm = FirebaseMessaging.instance;

    fbm.requestPermission().then((settings) async {
      print("Permission granted!");

      fbm.getToken().then((value) {
        print("Here is the token!!!!!");
        print(value);
      });

      fbm.subscribeToTopic('chat');

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
              alert: true, badge: true, sound: true);

      await FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {
        if (message != null) {
          print(message);
        }
      });

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        print(notification);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FlutterChat"), actions: [
        DropdownButton(
            underline: Container(),
            icon: Icon(Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color),
            items: [
              DropdownMenuItem(
                  child: Container(
                      child: Row(children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 8),
                    Text('Logout')
                  ])),
                  value: 'logout')
            ],
            onChanged: (dynamic itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            }),
      ]),
      body: Container(
          child: Column(children: [Expanded(child: Messages()), NewMessage()]))
      // StreamBuilder<QuerySnapshot>(
      //     stream: FirebaseFirestore.instance
      //         .collection('chats')
      //         .doc('N5epw3MNudRmrZUR2jVW')
      //         .collection('messages')
      //         .snapshots(),
      //     builder: (ctx, streamSnapShot) {
      //       if (streamSnapShot.connectionState == ConnectionState.waiting) {
      //         return Center(child: CircularProgressIndicator());
      //       }
      //       final documents = streamSnapShot.data.docs;
      //       return ListView.builder(
      //           itemCount: documents.length,
      //           itemBuilder: (ctx, index) => Container(
      //               padding: EdgeInsets.all(8),
      //               child: Text(documents[index]['text'])));
      //     })
      ,
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //       FirebaseFirestore.instance
      //           .collection('chats')
      //           .doc('N5epw3MNudRmrZUR2jVW')
      //           .collection('messages')
      //           .add({'text': 'This was added by clicking the button!'});
      //     })
    );
  }
}
