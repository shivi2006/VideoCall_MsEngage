import 'package:agora_video_call/Auth/Model/LoginRepository.dart';
import 'package:agora_video_call/utils/ConnectionState.dart';
import 'package:agora_video_call/utils/Failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:agora_video_call/utils/Functions.dart';

// Controller class for handling Login
class LoginController with ChangeNotifier {
  final LoginRepository _loginRepository;
  CurrentState currentState = CurrentState.Initial;
  LoginController(this._loginRepository);
  Either<Failure, dynamic> loginResult;

// Google Sign in 
  void googleSignIn() async {
    currentState = CurrentState.Loading;
    notifyListeners();
    await Task(() => _loginRepository.signInWithGoogle())
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((result) {
      loginResult = result;
    });
    currentState = CurrentState.Loaded;
    notifyListeners();
  }

// Sign in with email
  void signInWithEmail(String email, String password) async {
    currentState = CurrentState.Loading;
    notifyListeners();
    await Task(() => _loginRepository.signInWithEmail(email, password))
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((result) {
      loginResult = result;
    });
    currentState = CurrentState.Loaded;
    notifyListeners();
  }
}
