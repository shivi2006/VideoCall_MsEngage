import 'package:agora_video_call/Auth/EmailSignUp.dart';
import 'package:agora_video_call/Auth/Controller/LoginController.dart';
import 'package:agora_video_call/utils/ConnectionState.dart';
import 'package:agora_video_call/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginController>(
        builder: (context, controller, child) {
          final stack = Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('LOGIN',
                                    style:GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.blue)))),
                        Padding(
                            padding: EdgeInsets.all(4),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    ' Get Connected with your loved ones with a click',
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                        color: Colors.grey)))),
                        Divider(
                          thickness: 2,
                        ),
                        SizedBox(height: 60),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                              alignment: Alignment.center,
                              child: TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  
                                ),
                                textInputAction: TextInputAction.next,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Align(
                            alignment: Alignment.center,
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                              ),
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            alignment: Alignment.center,
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(25.0),
                              color: Colors.blue,
                              child: MaterialButton(
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.6,
                                padding:
                                    EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                                child: Text("Login",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(fontSize: 20).copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () async {
                                  if (_emailController.text.isEmpty ||
                                      _passwordController.text.isEmpty) {
                                    Fluttertoast.showToast(msg: EMPTY_FIELD);
                                  }
                                  controller.signInWithEmail(
                                      _emailController.text,
                                      _passwordController.text);
                                },
                              ),
                            )),
                        SizedBox(height: 3),
                        Container(
                          padding: EdgeInsets.all(4),
                          child: OutlineButton.icon(
                            label: Text(
                              'Sign In With Google',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            shape: StadiumBorder(),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            highlightedBorderColor: Colors.black,
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            textColor: Colors.black,
                            icon: FaIcon(FontAwesomeIcons.google,
                                color: Colors.blue),
                            onPressed: controller.googleSignIn,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 45),
                              child: Text('Not Registered Yet?', // If not a exisiting user, sign up with email and password
                                  style: GoogleFonts.lato(color: Colors.black)),
                            ),
                            TextButton(
                              child: Text('Sign up with email',
                                  style:GoogleFonts.lato(
                                    color: Colors.blue,
                                  )),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterEmailSection()),
                                );
                              },
                            ),
                          ]
                        ),
                            SizedBox(height: 20),
                            Container(
                              
                              child:Visibility(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: CircularProgressIndicator(),
                              ),
                              visible: controller.currentState ==
                                  CurrentState.Loading,
                            ),
                            )
                          ],
                        ),
                      ),
            ],
            // checks the state and displays accordingly
          );
          if (controller.currentState != CurrentState.Loaded) {
            return stack;
          } else if (controller.currentState == CurrentState.Loaded) {
            return controller.loginResult.fold((failure) {
              Fluttertoast.showToast(msg: failure.message);
              return stack;
            }, (user) {
              Fluttertoast.showToast(
                  msg: 'Welcome ${user.name == null ? '' : user.name}');
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed(HOME_ROUTE);
              });
              return Container();
            });
          } else
            return Container();
        },
      ),
    );
  }
}
