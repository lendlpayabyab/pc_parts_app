part 'package:pc_parts_app/models/part_model.dart';

class ShopMenu {
  String type;
  String imageLink;
  List<PartModel> partModel;

  ShopMenu({
    required this.type,
    required this.imageLink,
    this.partModel = const [],
  });

  factory ShopMenu.fromJson(Map<String, dynamic> json) {
    final partModel = <PartModel>[];

    if(json['model'] != null) {
      json['model'].forEach((v) {
        partModel.add(PartModel.fromJson(json));
      });
    }

    return (ShopMenu(
      type: json['type'] ?? "",
      imageLink: json['imageLink'] ?? "",
      partModel: partModel,
    ));
  }
}
