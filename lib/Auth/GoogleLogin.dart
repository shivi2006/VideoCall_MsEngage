import 'package:agora_video_call/DeviceSizeConfig.dart';
import 'package:agora_video_call/VideoCall/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//A class to login with google
class GoogleLoginWidget extends StatefulWidget {
  @override
  GoogleLoginWidgetState createState() => GoogleLoginWidgetState();
}

class GoogleLoginWidgetState extends State<GoogleLoginWidget> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth;

  bool isUserSignedIn = false;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  void initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    checkIfUserIsSignedIn();
  }

  void checkIfUserIsSignedIn() async {
    var userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: DeviceSizeConfig.screenWidth * 0.7,
        padding: EdgeInsets.all(4),
        child: ButtonTheme(
            child: OutlineButton.icon(
                label: Text(
                  'Sign In With Google',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                highlightedBorderColor: Colors.black,
                borderSide: BorderSide(
                  color: Colors.black,
                ),
                textColor: Colors.black,
                icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
                onPressed: () {
                  onGoogleSignIn(context);
                })));
  }

  Future<User> _handleSignIn() async {
    User user;
    bool userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });

    if (isUserSignedIn) {
      user = _auth.currentUser;
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      user = (await _auth.signInWithCredential(credential)).user;
      userSignedIn = await _googleSignIn.isSignedIn();
      setState(() {
        isUserSignedIn = userSignedIn;
      });
    }

    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    User user = await _handleSignIn();
    var userSignedIn = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );

    setState(() {
      isUserSignedIn = userSignedIn == null ? true : false;
    });
  }
}

/*void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
 */
