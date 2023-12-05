
class Beverages {
  late String name;
  late String sugars;
  late int size;
  late double strength;
  late String type;

  Beverages({required this.name, required this.sugars, required this.size, required this.strength, required this.type});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sugars': sugars,
      'strength': strength,
      'size': size,
      'type': type,
    };
  }
}

