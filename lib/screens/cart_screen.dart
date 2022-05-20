import 'package:pc_parts_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:pc_parts_app/models/models.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          final manager = Provider.of<CartManager>(context, listen: false);
          showModalBottomSheet(context: context, builder: (BuildContext context){
            return CartItemScreen(
              onUpdate: (item) {},
              onCreate: (item) {
                manager.addItem(item);
                Navigator.pop(context);
              },
            );
          });
        },
        child: const Icon(Icons.add),
      ),
      body: buildCartScreen(),
    );
  }

  Widget buildCartScreen(){
    return Consumer<CartManager>(
      builder: (context, manager, child){
        if(manager.cartItems.isNotEmpty){
          return CartListScreen(manager: manager);
        }
        else {
          return const EmptyCartScreen();
        }
      },
    );
  }
}
