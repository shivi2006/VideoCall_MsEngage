import 'package:agora_video_call/ProfileScreen/Model/LogoutRepository.dart';
import 'package:flutter/foundation.dart';

class ProfileController with ChangeNotifier {
  final ProfileRepository _profileRepository;
  ProfileController(this._profileRepository);

  Future<void> logOut() async {
    await _profileRepository.logOutUser();
  }
}
