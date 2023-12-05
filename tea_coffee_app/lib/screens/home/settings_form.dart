import '../../models/user.dart';
import '../../models/item.dart';
import '../../services/database.dart';
import '../../shared/loader.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'form.dart';

class settingsform extends StatefulWidget {
  settingsform({Key? key}) : super(key: key);

  @override
  State<settingsform> createState() => _settingsformState();
}

class _settingsformState extends State<settingsform> {
  final _formkey = GlobalKey<FormState>();
  //final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values

  @override
  Widget build(BuildContext context) {
    MyUser user = Provider.of<MyUser>(context);

    return StreamBuilder<MyUserData>(
        stream: DatabaseService(uid: user.uid).individualdata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            MyUserData? userData = snapshot.data;

            Beverages b = userData!.beverage;

            String username = userData.username;

            return form(
              beverage: b,
              username: username,
              formkey: _formkey,
            );
          } else {
            return const Loading();
          }
        });
  }
}
