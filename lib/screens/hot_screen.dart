import 'package:flutter/material.dart';
import 'package:pc_parts_app/components/components.dart';
import 'package:pc_parts_app/models/models.dart';
import 'package:pc_parts_app/api/mock_pc_shop_service.dart';

class HotScreen extends StatelessWidget {
  HotScreen({Key? key}) : super(key: key);

  final mockService = mockPCPartsAppService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getHotData(),
      builder: (BuildContext context, AsyncSnapshot<HotData> snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          final products = snapshot.data?.latestProducts ?? [];
          final feed = snapshot.data?.newsFeed ?? [];
          return ListView(
            children: [
              LatestProductsView(products: products),
              const SizedBox(height: 15,),
              FeedView(newsFeed: feed),
            ],
          );
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