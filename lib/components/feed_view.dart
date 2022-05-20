import 'package:flutter/material.dart';
import 'package:pc_parts_app/components/components.dart';
import 'package:pc_parts_app/models/models.dart';

class FeedView extends StatelessWidget {
  final List<NewsFeed> newsFeed;

  const FeedView({
    Key? key,
    required this.newsFeed,
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
            'Hot news and reviews!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ListView.separated(
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final feed = newsFeed[index];
              return FeedTile(newsFeed: feed);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 15,
              );
            },
            itemCount: newsFeed.length,
          ),
        ],
      ),
    );
  }
}
