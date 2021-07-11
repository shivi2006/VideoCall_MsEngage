import 'package:agora_video_call/utils/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileRepository {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;
  final FlutterSecureStorage _secureStorage;
  ProfileRepository(
    this._googleSignIn,
    this._firebaseAuth,
    this._secureStorage,
  );
  Future<void> logOutUser() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
    await _secureStorage.deleteAll();
    await _secureStorage.write(key: ONBOARDING, value: 'true');
  }
}
