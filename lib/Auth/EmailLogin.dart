
import 'package:agora_video_call/VideoCall/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

// Class to sign up with email and password
class EmailPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EmailPasswordFormState();
}

  class EmailPasswordFormState extends State<EmailPasswordForm> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in!')),
      body:Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
            decoration: const InputDecoration(labelText: 'Password'),
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
            child: RaisedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _signInWithEmailAndPassword();
                  // Navigate to Home Screen on clicking Login Button
                  Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MyHomePage()));
                }
              },
              child: const Text('Login'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _success == null
                  ? ''
                  : (_success
                  ? 'Successfully signed in ' + _userEmail
                  : 'Sign in failed'),
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
      )
    );
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
  final User user = (await _auth.signInWithEmailAndPassword(
    email: _emailController.text,
    password: _passwordController.text,
  )).user;
  
  if (user != null) {
    setState(() {
      _success = true;
      _userEmail = user.email;
    });
  } else {
    setState(() {
      _success = false;
    });
  }
}
  }