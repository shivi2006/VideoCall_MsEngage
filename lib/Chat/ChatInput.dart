import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

// A class for ChatInput Widget
class ChatInput extends StatelessWidget {
  final TextEditingController _inputController = TextEditingController();
  final Function sendMessage;
  ChatInput({@required this.sendMessage});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Flexible(
            child: Container(
              child: Padding(padding: EdgeInsets.all(15), child:TextField(
                  style: TextStyle(fontSize: 15.0),
                  controller: _inputController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Type a message',
                    hintStyle: GoogleFonts.lato(color: Colors.grey),
                  ),
                ),
              ),
            ),
            ),
          
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (_inputController.text.isEmpty) {
                Fluttertoast.showToast(msg: "Message cannot be empty");
              } else {
                sendMessage(_inputController.text);
                _inputController.text = "";
              }
            },
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
      width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.blue, width: 0.5)),
          color: Colors.white),
    );
  }
}
