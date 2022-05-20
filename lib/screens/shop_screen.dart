import 'package:flutter/material.dart';
import 'package:pc_parts_app/components/components.dart';
import 'package:pc_parts_app/models/models.dart';
import 'package:pc_parts_app/api/mock_pc_shop_service.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({Key? key}) : super(key: key);

  final mockService = mockPCPartsAppService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getShopMenu(),
      builder: (BuildContext context, AsyncSnapshot<List<ShopMenu>> snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return ShopView(shopMenu: snapshot.data?? []);
        }
        else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
