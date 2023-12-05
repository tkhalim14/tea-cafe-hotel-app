
import '../models/user.dart';
import '../models/item.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String uid;
  DatabaseService({required this.uid});
  //collection reference

  final CollectionReference usercollection =
      FirebaseFirestore.instance.collection('user_preferences');

  Future updateUserData(String username, Beverages beverage) async {
    if(uid=='' || username==''){
      return null;
    }
    return await usercollection.doc(uid).set({
      'uid': uid,
      'username': username,
      'beverage': beverage.toJson(),
    });
  }

  //list from snapshot
  List<Beverages> _listfromsnapshot(QuerySnapshot snapshot) {
    // if(snapshot==null) return [];
    return snapshot.docs.map((doc) {
      //print(doc);
      //doc.data.name;
      Map<String, dynamic> element = doc['beverage'];
      return Beverages(
        name: element['name'] ?? 'Unknown',
        sugars: element['sugars'] ?? 'Null',
        strength: element['strength'] ?? 0.00,
        size: element['size'] ?? 100,
        type: element['type'] ?? 'Null',
      );
    }).toList();
  }

  // userdata from snapshot

  MyUserData _userdatafromsnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> element = snapshot['beverage'];
    return MyUserData(
        uid: uid,
        username: snapshot['username'],
        beverage: Beverages(
          name: element['name'] ?? '',
          sugars: element['sugars'] ?? '',
          strength: element['strength'] ?? 0,
          size: element['size'] ?? 100,
          type: element['type'] ?? '',
        )
      );
  }

  // get datas stream
  Stream<List<Beverages>> get userdatas {
    return usercollection.snapshots().map(_listfromsnapshot);
  }

  // get individual data
  Stream<MyUserData> get individualdata {
    return usercollection.doc(uid).snapshots().map(_userdatafromsnapshot);
  }
}
