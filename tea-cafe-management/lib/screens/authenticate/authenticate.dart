import 'package:appwithfirebase/screens/authenticate/register.dart';
import 'package:appwithfirebase/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class authenticate extends StatefulWidget {
  authenticate({Key? key}) : super(key: key);

  @override
  State<authenticate> createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {
  bool toggle = false;

  void toggleview() {
    setState(() => toggle = !toggle);
  }

  @override
  Widget build(BuildContext context) {
    if (!toggle) {
      return signin(toggle: toggleview);
    } else {
      return register(toggle: toggleview);
    }
  }
}
