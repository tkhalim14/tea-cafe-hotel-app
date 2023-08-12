import 'package:appwithfirebase/services/auth.dart';
import 'package:appwithfirebase/shared/loader.dart';
import 'package:appwithfirebase/shared/textformstyling.dart';
import 'package:flutter/material.dart';

class signin extends StatefulWidget {
  Function toggle;
  signin({Key? key, required this.toggle}) : super(key: key);

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String errorMessage = '';

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return !loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.red[100],
            appBar: AppBar(
              backgroundColor: Colors.red[400],
              elevation: 0.0,
              title: Text('Sign in to Chai App'),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.toggle();
                    });
                  },
                  icon: Icon(Icons.app_registration),
                ),
                Center(
                  child: Text('Register'),
                ),
                SizedBox(
                  width: 5,
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Sign in Anonymously
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     dynamic result = await _auth.signinanon();
                  //     if (result == null) {
                  //       print('Error signing in');
                  //     } else {
                  //       print('Signed in successfully');
                  //       print(result.uid);
                  //     }
                  //   },
                  //   child: Text('Sign In Anonymously'),
                  // ),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            decoration: textformstyling.copyWith(
                              icon: const Icon(Icons.person),
                              hintText: 'Enter your email',
                              labelText: 'Email',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter an email';
                              }
                              return null;
                            },
                            onChanged: ((value) {
                              setState(() {
                                username = value;
                              });
                            })),
                        SizedBox(height: 30),
                        TextFormField(
                          decoration: textformstyling.copyWith(
                            icon: const Icon(
                              Icons.password,
                            ),
                            hintText: 'Enter your password',
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (value!.length < 6) {
                              return 'Enter a 6+ character password';
                            }
                            return null;
                          },
                          onChanged: ((value) {
                            setState(() {
                              password = value;
                            });
                          }),
                          obscureText: true,
                        ),
                        Text(
                          errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                loading = false;
                              });
                              dynamic result =
                                  await _auth.signinwithemailandpassword(
                                      username, password);
                              if (result == null) {
                                setState(() {
                                  errorMessage =
                                      'Please enter valid credentials';
                                  loading = true;
                                });
                              } else {
                                print('Signed in successfully');
                                print(result.email);
                              }
                            } else {}
                          },
                          child: Text('Sign in'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
