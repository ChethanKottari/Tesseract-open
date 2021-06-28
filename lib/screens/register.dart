import 'package:flutter/material.dart';
import 'package:tesseract/services/auth.dart';
import 'package:tesseract/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register(this.toggleView);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  String about = '';
  String name = '';
  String imageAvatar = '';
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
                Icons.login,
                color: Colors.white,
              ),
              label: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                ),
              ))
        ],
        backgroundColor: Color(0xFF1a2F45),
        title: Center(
          child: Text(
            "Sign Up to Tesseract",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Color(0xFF1a2F45),
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFF1a2F45),
                      Colors.black87,
                    ]),
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF1a2F45)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                        if (value.length < 6) {
                          return "Password should be atleast 6 characters";
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
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'What Do You wanna be called'),
                      validator: (value) {
                        if (value.length < 0) {
                          return "Name is necessary";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Select a mascot!'),
                        validator: (value) {
                          if (value == null) {
                            return "Select a Mascot";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            imageAvatar = value;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text("Baboon Mascot"),
                            value:
                                "https://homepages.cae.wisc.edu/~ece533/images/baboon.png",
                          ),
                          DropdownMenuItem(
                            child: Text("Lion Mascot"),
                            value:
                                "https://homepages.cae.wisc.edu/~ece533/images/cat.png",
                          ),
                          DropdownMenuItem(
                            child: Text("Eagle Mascot"),
                            value:
                                "https://homepages.cae.wisc.edu/~ece533/images/peppers.png",
                          ),
                          DropdownMenuItem(
                            child: Text("Bee Mascot"),
                            value:
                                "https://homepages.cae.wisc.edu/~ece533/images/monarch.png",
                          )
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Your Descrition',
                      ),
                      expands: false,
                      maxLines: 7,
                      minLines: null,
                      onChanged: (value) {
                        setState(() {
                          about = value;
                        });
                      },
                      validator: (value) {
                        if (value.length < 15) {
                          return "please atleast have 15 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                        elevation: 10,
                        color: Colors.orange,
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                    name: name,
                                    about: about,
                                    avatarurl: imageAvatar);
                            if (result == null) {
                              setState(() {
                                error = "please supply correct details";
                              });
                            }
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
