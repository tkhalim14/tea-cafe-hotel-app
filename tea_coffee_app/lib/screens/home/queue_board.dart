import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../models/item.dart';
import 'queue_tile.dart';

class MyLists extends StatefulWidget {
  //Stream<List<ListItems>> userdata;
  MyLists({Key? key}) : super(key: key);

  @override
  State<MyLists> createState() => _MyListsState();
}

class _MyListsState extends State<MyLists> {
  @override
  Widget build(BuildContext context) {
    final q = Provider.of<List<Beverages>>(context);
    /*q.forEach((list_item) {
      print(list_item.name);
      print(list_item.strength);
      print(list_item.sugars);
    });*/
    //print(q.docs.map((DocumentSnapshot Damn) => Damn.data()));
    return ListView.builder(
      shrinkWrap: true,
      itemCount: q.length,
      itemBuilder: (context, index) {
        return Listtile(item: q[index]);
      },
    );
  }
}
