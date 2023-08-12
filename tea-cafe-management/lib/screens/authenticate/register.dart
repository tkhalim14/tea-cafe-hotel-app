import 'package:appwithfirebase/services/auth.dart';
import 'package:appwithfirebase/shared/textformstyling.dart';
import 'package:appwithfirebase/shared/loader.dart';
import 'package:flutter/material.dart';

class register extends StatefulWidget {
  Function toggle;
  register({Key? key, required this.toggle}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
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
              title: Text('Register to demo'),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.toggle();
                    });
                  },
                  icon: Icon(Icons.person),
                ),
                Center(
                  child: Text('Sign in'),
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
                  Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
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
                          SizedBox(
                            height: 30,
                          ),
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
                          SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.registerwithemailandpassword(
                                        username, password);
                                if (result == null) {
                                  setState(() {
                                    errorMessage = 'please do it right';
                                    loading = false;
                                  });
                                }
                              } else {}
                            },
                            child: Text('Register'),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            errorMessage,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.0,
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ));
  }
}
