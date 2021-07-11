

import 'package:agora_video_call/Chat/MessageOwner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

// Model class for Message
class Message {
  final String text;
  final MessageOwner owner;
  final Timestamp time;
  final String name;

  Message({
    @required this.text,
    @required this.owner,
    @required this.time,
    @required this.name
  });

  // Checks for owner of Message
  factory Message.fromMap(Map<String, dynamic> map) {
    MessageOwner owner;
    if (map['owner'] == map['uid']) {
      owner = MessageOwner.Self;
    } else {
      owner = MessageOwner.Other;
    }
    return Message(text: map['text'], owner: owner, time: map['timestamp'], name:map['name']);
  }
}