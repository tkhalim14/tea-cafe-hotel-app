import '../../models/item.dart';
import '../../models/user.dart';
import '../../services/auth.dart';
import '../../services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


import 'settings_form.dart';
import 'queue_board.dart';

class home extends StatefulWidget {
  MyUser user;
  home({Key? key, required this.user}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showsettingspanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: settingsform(),
            );
          });
    }

    return StreamProvider<List<Beverages>>.value(
      value: DatabaseService(uid: widget.user.uid).userdatas,
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[400],
          title: Text('Home'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.people),
              onPressed: () async {
                await _auth.signout();
              },
            ),
            Center(child: Text("Sign out")),
            SizedBox(
              width: 10,
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                _showsettingspanel();
              },
            ),
            Center(child: Text("Settings")),
          ],
        ),
        body: MyLists(),
      ),
    );
  }
}
