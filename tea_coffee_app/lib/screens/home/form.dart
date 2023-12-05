import 'package:flutter/material.dart';
import '../../services/database.dart';
import '../../models/user.dart';
import '../../models/item.dart';
import 'package:provider/provider.dart';


const textformstyling = InputDecoration(
  //icon: const Icon(Icons.password),
  // hintText: 'Enter password',
  //labelText: 'Password',
  fillColor: Color.fromARGB(255, 255, 218, 218),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromARGB(134, 3, 168, 244),
      width: 2.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.lightBlue,
      width: 2.0,
    ),
  ),
);


class form extends StatefulWidget {
  dynamic formkey = GlobalKey<FormState>();

  Beverages beverage;
  String username;
  form(
      {Key? key,
      required this.beverage,
      required this.username,
      required this.formkey})
      : super(key: key){

      }

  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {

  final List<String> sugars = ['0', '1', '2', '3', '4','5'];
  late String name;
  
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
            initialValue: widget.beverage.name,
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
                // print(widget.name);
                widget.beverage.name = name;
                // print(val);
              });
            }),
          ),
          SizedBox(
            height: 20,
          ),
          DropdownButtonFormField(
            value: widget.beverage.sugars,
            decoration: textformstyling.copyWith(
              icon: Icon(Icons.coffee),
              labelText: 'Sugar(s)',
            ),
            items: sugars.map((e) {
              return DropdownMenuItem(value: e, child: Text(e));
            }).toList(),
            onChanged: (et) {
              setState(() {
                widget.beverage.sugars = et.toString();
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          //Slider
          Slider(
            value: widget.beverage.strength.toDouble(),
            min: 100,
            max: 900,
            activeColor: Colors.red[widget.beverage.strength.truncate()],
            inactiveColor: Colors.red[widget.beverage.strength.truncate()],
            divisions: 8,
            onChanged: (val) {
              setState(() {
                widget.beverage.strength = val.toDouble();
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              // print(widget.currentname);
              // print(widget.currentsugars);
              // print(widget.currentstrength);
              if (widget.formkey.currentState.validate()) {
                Beverages b = Beverages(name: widget.beverage.name, sugars: widget.beverage.sugars, size: widget.beverage.size, strength: widget.beverage.strength, type: widget.beverage.type);
                await DatabaseService(uid: user.uid).updateUserData(
                  widget.username,
                  b,
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
