import 'package:flutter/material.dart';
import 'package:pc_parts_app/models/models.dart';
import 'package:marquee/marquee.dart';

class CardBuilder extends StatelessWidget {

  final HotProducts products;
  const CardBuilder({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Center(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        constraints: const BoxConstraints.expand(
          width: 355,
          height: 450,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(products.image),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 13,
              child: Container(
                height: 30,
                width: 350,
                color: const Color(0xffffffff).withOpacity(0.5),
              ),
            ),
            Positioned(
              top: 20,
              left: 10,
              child: Text(
                '${products.manufacturer} ${products.model}'
              ),
            ),
            Positioned(
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 50,
                width: 350,
                color: const Color(0xffffffff).withOpacity(0.5),
                child: Marquee(
                  text: products.description,
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 5,
              child: Text(
                '₱${products.priceInPeso}',
                style: TextStyle(
                  fontSize: 20,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2.5
                    ..color = Colors.black,
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 50,
              child: Text(
                '₱${products.priceInPeso}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
