import 'package:flutter/material.dart';
import 'package:pc_parts_app/models/models.dart';
import 'package:intl/intl.dart';
import 'package:pc_parts_app/screens/screens.dart';

class ShopTile extends StatelessWidget {
  final ShopMenu shopMenu;
  final CartManager manager;

  const ShopTile({
    Key? key,
    required this.shopMenu,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductView(
                            shopMenu: shopMenu,
                            manager: manager,
                          )));
                },
                child: Hero(
                  tag: shopMenu.type,
                  child: Image(
                    image: AssetImage(shopMenu.imageLink),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            shopMenu.type.toUpperCase(),
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductView extends StatelessWidget {
  final ShopMenu shopMenu;
  final CartManager manager;

  const ProductView({
    Key? key,
    required this.shopMenu,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Hero(
                  tag: shopMenu.type,
                  child: SizedBox(
                    height: 200,
                    child: Image(
                      height: double.infinity,
                      width: double.infinity,
                      image: AssetImage(shopMenu.imageLink),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${shopMenu.type} models:'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Flexible(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final item = CartItem(
                      id: '',
                      type: shopMenu.type.toUpperCase(),
                      name: shopMenu.partModel[index].name.toUpperCase(),
                      price: shopMenu.partModel[index].price,
                      quantity: 1,
                      priority: Priority.NORMAL,
                    );
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return CartItemScreen(
                                originalItem: item,
                                onCreate: (item) {},
                                onUpdate: (item) {
                                  manager.addItem(item);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('${item.name} successfully added.'),
                                        duration: const Duration(milliseconds: 2500),
                                        /*
                                        action: SnackBarAction(
                                          label: 'Go to cart',
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        */
                                      ),
                                  );
                                },
                              );
                            });
                      },
                      child: ProductTile(
                        item: item,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                  itemCount: shopMenu.partModel.length),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final CartItem item;

  const ProductTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      padding: const EdgeInsets.all(5),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(item.name),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(NumberFormat('₱#,##0.00').format(item.price)),
        ],
      ),
    );
  }
}
