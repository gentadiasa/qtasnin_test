class Item {
  final String? id;
  final String name;
  final String type;
  final int stock;

  Item({this.id, required this.name, required this.type, required this.stock});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      stock: json['stock'],
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stock': stock,
      'name': name,
      'type': type,
    };
  }
}
