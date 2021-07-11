import 'package:agora_video_call/utils/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// A class for chat fucntions
class ChatRepository {
 
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FlutterSecureStorage secureStorage = new FlutterSecureStorage();
  
  // Function for updating the message in firestore
  void sendMessage(String text) async {
    var id = await secureStorage.read(key: UID);
    var name = await secureStorage.read(key: 'name');
    print('Name: $name');
    var batch = firestore.batch();
    batch.set(firestore.collection('ChatRooms').doc(), {
      'text': text,
      'owner': id,
      'timestamp': Timestamp.now(),
      'name': name
    });

    await batch.commit();
  }

  // Function for obtaining the messages from firestore
  Query getChatQuery() {
    return firestore
        .collection('ChatRooms')
        .orderBy('timestamp', descending: true);
  }

// Function for deleting all chats when the user ends the call
  Future<void> batchDelete() {
    CollectionReference chats =
        FirebaseFirestore.instance.collection('ChatRooms');

    WriteBatch batch = FirebaseFirestore.instance.batch();
  
    
    return chats.get().then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });

      return batch.commit();
    });
  }}

