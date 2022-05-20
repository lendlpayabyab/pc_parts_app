import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pc_parts_app/components/cart_tile.dart';
import 'package:pc_parts_app/models/models.dart';
import 'package:pc_parts_app/screens/screens.dart';


class CartListScreen extends StatelessWidget {
  final CartManager manager;

  const CartListScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartItems = manager.cartItems;

    double totalPrice = 0;

    for (var element in cartItems) {
      totalPrice += element.price * element.quantity;
    }

    // TODO: make a cart list screen
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Dismissible(
                    key: Key(item.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                        padding: const EdgeInsets.only(
                          right: 10,
                        ),
                        alignment: Alignment.centerRight,
                        color: Colors.blue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Delete Entry',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    onDismissed: (direction) {
                      manager.deleteItem(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item.name} removed'),
                          duration: const Duration(milliseconds: 2500),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              manager.addItem(item);
                            },
                          ),
                        ),
                      );
                    },
                    child: InkWell(
                      child: CartTile(
                        item: item,
                        key: Key(item.id),
                      ),
                      onTap: () {
                        showModalBottomSheet(context: context, builder: (BuildContext context){
                          return CartItemScreen(
                            originalItem: item,
                            onUpdate: (item) {
                              manager.updateItem(item, index);
                              Navigator.pop(context);
                            },
                            onCreate: (item) {},
                          );
                        });
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemCount: cartItems.length,
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Total Price: ${NumberFormat('₱#,##0.00').format(totalPrice)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
