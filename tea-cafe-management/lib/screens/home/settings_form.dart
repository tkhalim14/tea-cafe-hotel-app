import 'package:appwithfirebase/models/user.dart';
import 'package:appwithfirebase/services/database.dart';
import 'package:appwithfirebase/shared/loader.dart';
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
  late String _currentname;
  late String _currentsugars;
  late int _currentstrength;

  @override
  Widget build(BuildContext context) {
    MyUser user = Provider.of<MyUser>(context);

    return StreamBuilder<MyUserData>(
        stream: databaseService(uid: user.uid).individualdata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            MyUserData? userData = snapshot.data;
            _currentstrength = userData!.strength;
            _currentsugars = userData.sugar;
            _currentname = userData.name;

            return form(
              currentname: _currentname,
              currentstrength: _currentstrength,
              currentsugars: _currentsugars,
              formkey: _formkey,
            );
          } else {
            return Loading();
          }
        });
  }
}
