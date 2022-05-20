import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pc_parts_app/models/models.dart';

class mockPCPartsAppService{

  Future<HotData> getHotData() async{
    final latestProducts = await _getLatestProducts();
    final newsFeed = await _getNewsFeed();
    return HotData(latestProducts, newsFeed);
  }

  Future<List<HotProducts>> _getLatestProducts() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final dataString = await _loadAsset('assets/sample_data/sample_products.json');

    final Map<String, dynamic> json = jsonDecode(dataString);

    if(json['products'] != null){
      final products = <HotProducts>[];
      json['products'].forEach((v) {
        products.add(HotProducts.fromJson(v));
      });
      return products;
    }
    else{
      return List.empty(growable: true);
    }
  }

  Future<List<NewsFeed>> _getNewsFeed() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final dataString = await _loadAsset('assets/sample_data/sample_newsfeed.json');

    final Map<String, dynamic> json = jsonDecode(dataString);

    if(json['reviews'] != null){
      final reviews = <NewsFeed>[];
      json['reviews'].forEach((v) {
        reviews.add(NewsFeed.fromJson(v));
      });
      return reviews;
    }
    else{
      return List.empty(growable: true);
    }
  }

  Future<List<ShopMenu>> getShopMenu() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final dataString = await _loadAsset('assets/sample_data/buy_menu.json');

    final Map<String, dynamic> json = jsonDecode(dataString);

    if(json['parts'] != null){
      final parts = <ShopMenu>[];
      json['parts'].forEach((v) {
        parts.add(ShopMenu.fromJson(v));
      });

      for (int i = 0; i < parts.length; i++){
        parts[i].partModel = List.empty(growable: true);
        json['parts'][i]['model'].forEach((v) {
          parts[i].partModel.add(PartModel.fromJson(v));
        });
      }

      return parts;
    }
    else{
      return List.empty(growable: true);
    }
  }

  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }
}