import 'package:pc_parts_app/models/models.dart';

class HotData{
  final List<HotProducts> latestProducts;
  final List<NewsFeed> newsFeed;

  HotData(
    this.latestProducts,
    this.newsFeed,
  );
}