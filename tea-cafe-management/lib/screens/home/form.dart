import 'package:flutter/material.dart';
import 'package:appwithfirebase/shared/textformstyling.dart';
import 'package:appwithfirebase/services/database.dart';
import 'package:appwithfirebase/models/user.dart';
import 'package:provider/provider.dart';

class form extends StatefulWidget {
  dynamic formkey = GlobalKey<FormState>();

  late String currentsugars;
  late String currentname;
  late int currentstrength;
  form(
      {Key? key,
      required this.currentname,
      required this.currentstrength,
      required this.currentsugars,
      required this.formkey})
      : super(key: key);

  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  late String name; // Some weird problem XP
  @override
  Widget build(BuildContext context) {
    MyUser user = Provider.of<MyUser>(context);
    return Form(
      key: widget.formkey,
      child: Column(
        children: [
          Text(
            "Update your choice.",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            key: widget.key,
            initialValue: widget.currentname,
            decoration: textformstyling.copyWith(
              icon: const Icon(Icons.person),
              hintText: 'Enter your Name',
              labelText: 'Username',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a username';
              }
              return null;
            },
            onChanged: ((val) {
              setState(() {
                name = val.toString();
                print(widget.currentname);
                print(val);
              });
            }),
          ),
          SizedBox(
            height: 20,
          ),
          DropdownButtonFormField(
            value: widget.currentsugars,
            decoration: textformstyling.copyWith(
              icon: Icon(Icons.coffee),
              labelText: 'Sugar(s)',
            ),
            items: sugars.map((e) {
              return DropdownMenuItem(value: e, child: Text(e));
            }).toList(),
            onChanged: (et) {
              setState(() {
                widget.currentsugars = et.toString();
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          //Slider
          Slider(
            value: widget.currentstrength.toDouble(),
            min: 100,
            max: 900,
            activeColor: Colors.red[widget.currentstrength],
            inactiveColor: Colors.red[widget.currentstrength],
            divisions: 8,
            onChanged: (val) {
              setState(() {
                widget.currentstrength = val.toInt();
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              print(widget.currentname);
              print(widget.currentsugars);
              print(widget.currentstrength);
              if (widget.formkey.currentState.validate()) {
                await databaseService(uid: user.uid).updateuserdata(
                  widget.currentsugars,
                  name,
                  widget.currentstrength,
                );
                Navigator.pop(context);
              }
            },
            child: Text("UPDATE"),
          )
        ],
      ),
    );
  }
}
