import 'package:agora_video_call/ProfileScreen/Controller/LogoutContoller.dart';
import 'package:agora_video_call/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogOut extends StatelessWidget {
  Widget build(BuildContext context) {
    return 
          IconButton(
            icon: Icon(Icons.exit_to_app_outlined),
            onPressed: () async {
              await Provider.of<ProfileController>(context, listen: false)
                  .logOut();
              Navigator.pushReplacementNamed(context, AUTH_ROUTE);
            },
            iconSize: 30,
          );
  }
}
