import 'package:agora_video_call/Chat/Message.dart';
import 'package:agora_video_call/Chat/MessageOwner.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// UI for each message bubble
class ChatItem extends StatelessWidget {
  final Message message;
  ChatItem({@required this.message});
  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle recievedMessageStyle = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    BubbleStyle myMessageStyle = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Colors.blue,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );

    return Bubble(
      style: message.owner == MessageOwner.Self //checks if message is sent or received and dusplays accordingly
          ? myMessageStyle
          : recievedMessageStyle,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.name,
              style: GoogleFonts.lato(fontSize: 15, color: Colors.purple),
              textAlign: TextAlign.left,
            ),
            Text(message.text,
                style: GoogleFonts.lato(fontSize: 15),
                textAlign: TextAlign.left),
          ],
        ),
      );
  }
}
