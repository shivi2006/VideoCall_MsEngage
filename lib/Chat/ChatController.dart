import 'package:agora_video_call/Chat/ChatRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

//Controller class
class ChatController with ChangeNotifier {
  
  ChatRepository chatRepository;
  ChatController(this.chatRepository);

  Query chatQuery() => chatRepository.getChatQuery();
  void sendMessage(String text) => chatRepository.sendMessage(text);
}
