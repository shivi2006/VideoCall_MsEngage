import 'package:agora_video_call/Auth/Controller/LoginController.dart';
import 'package:agora_video_call/Auth/Model/LoginRepository.dart';
import 'package:agora_video_call/Auth/VIew/LoginScreen.dart';
import 'package:agora_video_call/OnboardingScreen/OnboardingScreen.dart';
import 'package:agora_video_call/ProfileScreen/Controller/LogoutContoller.dart';
import 'package:agora_video_call/ProfileScreen/Model/LogoutRepository.dart';
import 'package:agora_video_call/VideoCall/pages/HomePage.dart';
import 'package:agora_video_call/utils/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'OnboardingScreen/OnboardingScreen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  // initialise Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  // Loads the Onboarding/ Login/ Homescreen according to State of User
  if ((await secureStorage.read(key: UID)) != null) {
    runApp(MyApp(
      initialRoute: HOME_ROUTE,
      secureStorage: secureStorage,
    ));
  } else if ((await secureStorage.read(key: ONBOARDING)) != null) {
    runApp(MyApp(
      initialRoute: AUTH_ROUTE,
      secureStorage: secureStorage,
    ));
  } else {
    runApp(MyApp(
      initialRoute: ONBOARDING_ROUTE,
      secureStorage: secureStorage,
    ));
  }
}

class MyApp extends StatelessWidget {
  final initialRoute;
  final FlutterSecureStorage secureStorage;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  MyApp({this.initialRoute, this.secureStorage});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      // Different routes in app
      routes: {
        ONBOARDING_ROUTE: (_) => OnboardingScreen(secureStorage),
        AUTH_ROUTE: (_) => ChangeNotifierProvider(
              create: (context) => LoginController(
                LoginRepository(
                    _googleSignIn, _firebaseAuth, _firestore, secureStorage),
              ),
              child: LoginScreen(),
            ),
        HOME_ROUTE: (_) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => ProfileController(
                    ProfileRepository(
                        _googleSignIn, _firebaseAuth, secureStorage),
                  ),
                  
                ),
              ],
               child:MyHomePage(),
        ),

      }
    );
  }
}
