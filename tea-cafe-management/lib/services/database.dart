import 'package:appwithfirebase/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appwithfirebase/models/list_item.dart';

class databaseService {
  String? uid;
  databaseService({required this.uid});
  //collection reference

  final CollectionReference mycollection =
      FirebaseFirestore.instance.collection('userdatas');

  Future updateuserdata(String sugars, String name, int Strength) async {
    return await mycollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': Strength,
    });
  }

  //list from snapshot
  List<ListItems> _listfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc);
      //doc.data.name;
      return ListItems(
        name: doc['name'] ?? '',
        strength: doc['strength'] ?? 0,
        sugars: doc['sugars'] ?? '',
      );
    }).toList();
  }

  // userdata from snapshot

  MyUserData _userdatafromsnapshot(DocumentSnapshot snapshot) {
    return MyUserData(
        uid: uid!,
        name: snapshot['name'],
        sugar: snapshot['sugars'],
        strength: snapshot['strength']);
  }

  // get datas stream
  Stream<List<ListItems>> get userdatas {
    return mycollection.snapshots().map(_listfromsnapshot);
  }

  // get individual data
  Stream<MyUserData> get individualdata {
    return mycollection.doc(uid).snapshots().map(_userdatafromsnapshot);
  }
}
