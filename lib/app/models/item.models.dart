import 'dart:convert';

class Item {
  String? id;
  String? image;
  String? name;
  String? categoryName;
  Item({
    this.id,
    this.image,
    this.name,
    this.categoryName,
  });

  Item copyWith({
    String? id,
    String? image,
    String? name,
    String? categoryName,
  }) {
    return Item(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'categoryName': categoryName,
    };
  }

  factory Item.fromMap(map) {
    return Item(
      id: map['id'] != null ? map['id'] : null,
      image: map['image'] != null ? map['image'] : null,
      name: map['name'] != null ? map['name'] : null,
      categoryName: map['categoryName'] != null ? map['categoryName'] : null,
    );
  }
}
