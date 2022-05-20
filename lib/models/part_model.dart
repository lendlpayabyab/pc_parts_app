part of 'package:pc_parts_app/models/shop_menu.dart';

class PartModel {
  String name;
  double price;

  PartModel({
    required this.name,
    required this.price,
  });

  factory PartModel.fromJson(Map<String, dynamic> json) {
    return PartModel(
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
    );
  }
}
