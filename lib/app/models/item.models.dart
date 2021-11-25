
class Item {
  String? id;
  String? image;
  String? name;
  int? price;
  String? categoryName;
  Item({
    this.id,
    this.image,
    this.name,
    this.price,
    this.categoryName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'price': price,
      'categoryName': categoryName,
    };
  }

  factory Item.fromMap(map) {
    return Item(
      id: map['id'] != null ? map['id'] : null,
      image: map['image'] != null ? map['image'] : null,
      name: map['name'] != null ? map['name'] : null,
      price: map['price'] != null ? map['price'] : null,
      categoryName: map['categoryName'] != null ? map['categoryName'] : null,
    );
  }
}
