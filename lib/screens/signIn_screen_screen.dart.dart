import 'package:flutter/material.dart';
import 'package:tesseract/screens/user_profile.dart';
import 'package:tesseract/services/auth.dart';
import 'package:tesseract/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn(this.toggleView);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF1a2F45),
        appBar: AppBar(
          elevation: 0,
          actions: [
            FlatButton.icon(
                onPressed: () {
                  widget.toggleView();
                },
                icon: Icon(
                  Icons.people,
                  color: Colors.white,
                ),
                label: Text(
                  "Create account?",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
          ],
          backgroundColor: Color(0xFF1a2F45),
          title: SingleChildScrollView(
            child: Center(
              child: Text(
                "SignIn to Tesseract",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        body: Container(
          color: Color(0xFF1a2F45),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF1a2F45)),
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                        child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images.jpg'),
                      radius: 100,
                    )
                        // backgroundImage: AssetImage('assets/images.jpg' ),
                        ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter a mail";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter a password";
                        }
                        return null;
                      },
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                        elevation: 10,
                        color: Colors.orange,
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            dynamic result =
                                await _auth.signInWithEmailAndPassword(
                              email,
                              password,
                            );

                            if (result == null) {
                              setState(() {
                                error = "could not sign you In";
                              });
                            }
                          }
                        }),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
