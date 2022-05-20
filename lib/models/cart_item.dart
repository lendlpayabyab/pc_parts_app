enum Priority {
  LOW,
  NORMAL,
  HIGH,
}

class CartItem {
  String id;
  String type;
  String name;
  double price;
  int quantity;
  Priority priority;

  CartItem({
    required this.id,
    required this.type,
    required this.name,
    required this.price,
    required this.quantity,
    required this.priority,
  });

  CartItem copyWith({
    String? id,
    String? type,
    String? name,
    double? price,
    int? quantity,
    Priority? priority,
  }) {
    return CartItem(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      priority: priority ?? this.priority,
    );
  }
}
