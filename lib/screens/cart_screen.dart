import 'package:pc_parts_app/api/mock_pc_shop_service.dart';
import 'package:pc_parts_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:pc_parts_app/models/models.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final mockService = mockPCPartsAppService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getShopMenu(),
      builder: (BuildContext context, AsyncSnapshot<List<ShopMenu>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              mini: true,
              onPressed: () {
                final manager =
                    Provider.of<CartManager>(context, listen: false);
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return CartItemScreen(
                        onUpdate: (item) {},
                        onCreate: (item) {
                          manager.addItem(item);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('${item.name} successfully added.'),
                            duration: const Duration(milliseconds: 1500),
                          ));
                        },
                      );
                    });
              },
              child: const Icon(Icons.add),
            ),
            body: buildCartScreen(),
          );
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildCartScreen() {
    return Consumer<CartManager>(
      builder: (context, manager, child) {
        if (manager.cartItems.isNotEmpty) {
          return CartListScreen(manager: manager);
        } else {
          return const EmptyCartScreen();
        }
      },
    );
  }
}
