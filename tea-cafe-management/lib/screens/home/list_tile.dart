import 'package:flutter/material.dart';
import 'package:appwithfirebase/models/list_item.dart';

class Listtile extends StatelessWidget {
  final ListItems item;
  Listtile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Expanded(
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.red[item.strength],
            ),
            title: Text(item.name),
            subtitle: Text('Takes ${item.sugars} sugar(s)'),
          ),
        ),
      ),
    );
  }
}
