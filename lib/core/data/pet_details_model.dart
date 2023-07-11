import 'dart:convert';

List<PetDetailsModel> petDetailsModelFromJson(String str) => List<PetDetailsModel>.from(json.decode(str).map((x) => PetDetailsModel.fromJson(x)));

String petDetailsModelToJson(List<PetDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PetDetailsModel {
  int id;
  String name;
  int age;
  int price;
  String image;
  String description;
  String longDescription;
  String breed;
  Category? category;
  bool? isAdopted;
  DateTime? adoptedAt;

  PetDetailsModel({
    required this.id,
    required this.name,
    required this.age,
    required this.price,
    required this.image,
    required this.description,
    required this.longDescription,
    required this.breed,
    required this.category,
    this.isAdopted,
    this.adoptedAt
  });

  factory PetDetailsModel.fromJson(Map<String, dynamic> json) => PetDetailsModel(
    id: json["id"],
    name: json["name"],
    age: json["age"],
    price: json["price"],
    image: json["image"],
    description: json["description"],
    longDescription: json["long_description"],
    breed: json["breed"],
    category: categoryValues.map[json["category"]],
    isAdopted: json["isAdopted"] ?? false,
    adoptedAt: DateTime.tryParse(json["adoptedAt"].toString())
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "age": age,
    "price": price,
    "image": image,
    "description": description,
    "long_description": longDescription,
    "breed": breed,
    "category": categoryValues.reverse[category],
    "isAdopted": isAdopted ?? false,
    "adoptedAt" : adoptedAt?.toIso8601String()
  };
}

enum Category { DOG, CAT }

final categoryValues = EnumValues({
  "Cat": Category.CAT,
  "Dog": Category.DOG
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
