import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pc_parts_app/models/models.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.asset('assets/app_pics/empty_list.png'),
              ),
            ),
            const Text(
              'No items in the cart'
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Tap the + button to add items'
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              textColor: Colors.white,
              color: Colors.teal,
              onPressed: (){
                Provider.of<TabManager>(context, listen: false).goToShop();
              },
              child: const Text(
                'Browse Products'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
