
import 'package:agora_video_call/utils/Constants.dart';
import 'package:agora_video_call/utils/Failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:agora_video_call/Auth/Model/User.dart' as authModel;


// All the login functions are written in the class
class LoginRepository {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final FlutterSecureStorage _secureStorage;

  LoginRepository(this._googleSignIn, this._firebaseAuth, this._firestore,
      this._secureStorage);

// Sign in with google
  Future<dynamic> signInWithGoogle() async {
    GoogleSignInAccount account;
    try {
      account = await _googleSignIn.signIn();
      if (account == null)
        throw Failure('Sigin was aborted');
      else {
        var auth = await account.authentication;
        var userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          accessToken: auth.accessToken,
          idToken: auth.idToken,
        ));
        return await _completeAuth(userCredential.user);
      }
    } on FirebaseAuthException catch (error) {
      throw Failure(error.message);
    } on PlatformException catch (error) {
      if (error.code == 'network_error')
        throw Failure('Not connected to internet');
    } catch (unexpectedError) {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      throw Failure('An unexpected error has occoured ($unexpectedError)');
    }
  }
// Sign in with email
  Future<dynamic> signInWithEmail(String email, String password) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return await _completeAuth(userCredential.user);
    } on FirebaseAuthException catch (error) {
      throw Failure(error.message);
    } on PlatformException catch (error) {
      if (error.code == 'network_error')
        throw Failure('Not connected to internet');
    } catch (unexpectedError) {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      throw Failure('An unexpected error has occoured ($unexpectedError)');
    }
  }

  Future<authModel.User> _completeAuth(User firebaseUser) async {
    authModel.User user = authModel.User(
      uid: firebaseUser.uid,
      name: firebaseUser.displayName,
      email: firebaseUser.email,
    );
    var userRecords =
        await _firestore.collection(USERS_COLLECTION).doc(user.uid).get();
    if (userRecords.exists) {
      user = authModel.User.fromMap(userRecords.data());
    } else {
      await _firestore
          .collection(USERS_COLLECTION)
          .doc(user.uid)
          .set(user.toMap());
    }
    await _secureStorage.write(key: UID, value: user.uid); 
    // Stores name and id of logged in user
    print('Name Login: ${user.name}');
    print('User id: $user.uid');
    await _secureStorage.write(key: 'name', value: user.name);
    return user;
  }
}
