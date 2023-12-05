import '../../models/user.dart';
import '../../screens/authenticate/authenticate.dart';
import '../../screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class wrapper extends StatelessWidget {
  const wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Returns either home or authenticate
    final user = Provider.of<MyUser?>(context);

    if (user == null) {
      return authenticate();
    } else {
      return home(user: user);
    }
  }
}
