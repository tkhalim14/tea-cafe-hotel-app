import './item.dart';

class MyUser {
  final String uid;
  final String email;
  MyUser({required this.uid, required this.email});
}

class MyUserData {
  final String uid;
  final String username;
  final Beverages beverage;

  MyUserData({
    required this.uid,
    required this.username,
    required this.beverage
  });
}
