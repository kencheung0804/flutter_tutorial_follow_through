import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/widgets/chat/messages.dart';
import 'package:firebase_demo/widgets/chat/new_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FlutterChat"), actions: [
        DropdownButton(
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
            onChanged: (itemIdentifier) {
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
