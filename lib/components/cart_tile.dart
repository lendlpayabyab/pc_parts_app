import 'package:flutter/material.dart';
import 'package:pc_parts_app/models/models.dart';
import 'package:intl/intl.dart';

class CartTile extends StatelessWidget {
  final CartItem item;

  const CartTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: make cart tile widget
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      padding: const EdgeInsets.all(5),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.type,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(item.name),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Text(
                    'Quantity: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${item.quantity}',
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Priority: ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  buildPriority(),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Price: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    NumberFormat('₱#,##0.00').format(item.price * item.quantity),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPriority() {
    if (item.priority == Priority.LOW) {
      return const Text(
        'Low',
        style: TextStyle(
          fontSize: 15,
          color: Colors.yellow,
        ),
      );
    } else if (item.priority == Priority.NORMAL) {
      return const Text(
        'Normal',
        style: TextStyle(
          fontSize: 15,
          color: Colors.green,
        ),
      );
    } else if (item.priority == Priority.HIGH) {
      return const Text(
        'High',
        style: TextStyle(
          fontSize: 15,
          color: Colors.red,
        ),
      );
    } else {
      throw Exception('This importance type does not exist');
    }
  }
}
