import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

// Class to sign up with email and password
class RegisterEmailSection extends StatefulWidget {
  final String title = 'Registration';
  @override
  State<StatefulWidget> createState() => 
      RegisterEmailSectionState();
}
class RegisterEmailSectionState extends State<RegisterEmailSection> {

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
bool _success;
String _userEmail;

@override
Widget build(BuildContext context) {
  return Scaffold(
      body: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(alignment: Alignment.centerLeft, child:Padding(padding: EdgeInsets.all(10),child:
          Text('Create an Account', 
          style: GoogleFonts.lato(color: Colors.blue, fontSize:30, fontWeight: FontWeight.bold)))),
          SizedBox(height: 10,),
          Padding(
          padding: EdgeInsets.all(16.0),
          child:TextFormField(
            
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          ),
          Padding(
           padding: EdgeInsets.all(16.0),
           child:
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 
                'Password'),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: OutlinedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _register();
                  // Navigate back to Login screen after message shows up
                  // Navigator.pop(context);
                }
              },
              child: const Text('Sign Up', ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(_success == null
                ? ''
                : (_success
                    ? 'Successfully registered ' + _userEmail
                    : 'Registration failed'))
          )
        ],
      ),
      )
  );
}


void _register() async {
   User user = (await 
      _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      )
  ).user;
  if (user != null) {
    setState(() {
      _success = true;
      _userEmail = user.email;
    });
  } else {
    setState(() {
      _success = true;
    });
  }
}
@override
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
  super.dispose();
}
}

