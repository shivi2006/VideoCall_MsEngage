import 'package:agora_video_call/ProfileScreen/View/LogoutWidegt.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'dart:async';
import 'CallPage.dart';


// HomePage class to enter and join video call
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  bool _validateError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyTeams',
          style: GoogleFonts.lato(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          LogOut(),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Image.asset('assets/homepage.png'),
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Text(
                    "Let's Start Connecting!",
                    style: GoogleFonts.lato(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: myController,
                      decoration: InputDecoration(
                        labelText: 'Meeting Code',
                        labelStyle: GoogleFonts.lato(color: Colors.blue),
                        hintText: 'meetXYZ',
                        hintStyle: GoogleFonts.lato(color: Colors.black45),
                        errorText:
                            _validateError ? 'Channel name is mandatory' : null,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      children: [
                        Text('Join with the meeting code',
                            style:GoogleFonts.lato(fontSize: 15, color: Colors.grey)),
                        Divider(
                          thickness: 2,
                        ),
                        ElevatedButton(
                          onPressed: onJoin, //Join button
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Join',
                                style: GoogleFonts.lato(
                                    color: Colors.white, fontSize: 14),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Invite with a meeting code',
                            style:GoogleFonts.lato(fontSize: 15, color: Colors.grey)),
                        Divider(
                          thickness: 2,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ElevatedButton(
                            onPressed: onShare, // Share button
                            child: Text(
                              "Share", style: GoogleFonts.lato( color: Colors.white, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 
 //Check if channel name is empty and share accordingly
  Future<void> onShare() async {
    setState(() {
      myController.text.isEmpty
          ? null
          : Share.share(
              'Hey, I am inviting you to join my video call on MyTeams Mobile App.The code for joining video call is : ${myController.text}');
    });
  }

// Checks if channel field is empty and handle permissions accordingly
  Future<void> onJoin() async {
    setState(() {
      myController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });

    await _handleCameraAndMic(Permission.camera);

    await _handleCameraAndMic(Permission.microphone);

    myController.text.isEmpty
        ? null
        : await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CallPage(channelName: myController.text),
            ));
  }

  void _handleCameraAndMic(Permission permission) async {
    myController.text.isEmpty == false ? await permission.request() : null;
  }
}
