import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  ChatAppBar({@required this.title, 
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 6.0,
          )
        ],
      ),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: GoogleFonts.lato(),),
              SizedBox(
                height: 5,
              ),
              // FittedBox(
              //   child: Text(description),
              // )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
