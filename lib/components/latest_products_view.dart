import 'package:flutter/material.dart';
import 'package:pc_parts_app/models/models.dart';
import 'package:pc_parts_app/components/components.dart';

class LatestProductsView extends StatelessWidget {

  final List<HotProducts> products;

  const LatestProductsView({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hot new products!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 400,
            color: Colors.transparent,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const PageScrollPhysics(),
              itemBuilder: (context, index){
                final product = products[index];
                return CardBuilder(products: product);
              },
              separatorBuilder: (context, index){
                return const SizedBox(
                  width: 10,
                );
              },
              itemCount: products.length,
            ),
          ),
        ],
      ),
    );
  }
}
