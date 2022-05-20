class HotProducts{
  String part;
  String manufacturer;
  String model;
  String image;
  String description;
  int priceInPeso;

  HotProducts({
    required this.part,
    required this.manufacturer,
    required this.model,
    this.image = '',
    this.description = '',
    this.priceInPeso = 0,
  });

  factory HotProducts.fromJson(Map<String, dynamic> json) {
    return HotProducts(
      part: json['part'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      model: json['model'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      priceInPeso: json['priceInPeso'] ?? 0,
    );
  }
}