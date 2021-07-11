import 'package:agora_video_call/Chat/ChatController.dart';
import 'package:agora_video_call/Chat/ChatInput.dart';
import 'package:agora_video_call/Chat/ChatItem.dart';
import 'package:agora_video_call/Chat/Message.dart';
import 'package:agora_video_call/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FlutterSecureStorage secureStorage = new FlutterSecureStorage();

  var selfid;
// Method to read id of user
  Future<void> callId() async {
    var id = await secureStorage.read(key: UID);
    setState(() {
      selfid = id;
    });
  }

  @override
  void initState() {
    super.initState();
    callId();
  }

  Widget build(BuildContext context) {
    final controller = Provider.of<ChatController>(context, listen: false);
    final refreshListener = PaginateRefreshedChangeListener();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text(
          'Group Chat',
          style: GoogleFonts.lato(),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: PaginateFirestore(
              itemBuilder: (index, context, documentSnapshot) {
                final data = documentSnapshot.data() as Map<String, dynamic>; // Viewing the messages
                data.addAll({'uid': selfid}); //adding the id of user in map
                print("Data printed:$data");
                return ChatItem(
                  message: Message.fromMap(data),
                );
              },
              query: controller.chatQuery(), 
              itemBuilderType: PaginateBuilderType.listView,
              isLive: true,
              itemsPerPage: 20,
              padding: EdgeInsets.all(10.0),
              reverse: true,
              listeners: [refreshListener],
              emptyDisplay: Center( // Empty chats case handled
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () => refreshListener.refreshed = true,
                      child: Text(
                        'Retry',
                      ),
                    )
                  ],
                ),
              ),
              onError: (exception) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      exception.toString(),
                    ),
                    TextButton(
                      onPressed: () => refreshListener.refreshed = true,
                      child: Center(
                        child: Text(
                          'Retry',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          ChatInput(
            sendMessage: controller.sendMessage,
          ),
        ],
      ),
    );
  }
}
