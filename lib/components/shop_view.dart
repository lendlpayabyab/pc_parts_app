import 'package:flutter/material.dart';
import 'package:pc_parts_app/components/components.dart';
import 'package:pc_parts_app/models/models.dart';

class ShopView extends StatelessWidget {
  final List<ShopMenu> shopMenu;

  const ShopView({
    Key? key,
    required this.shopMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      child: GridView.builder(
        itemCount: shopMenu.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index){
          final shopItem = shopMenu[index];
          return ShopTile(shopMenu: shopItem);
        },
      ),
    );
  }
}
