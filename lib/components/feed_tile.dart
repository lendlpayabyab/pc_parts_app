import 'package:flutter/material.dart';
import 'package:pc_parts_app/models/models.dart';

class FeedTile extends StatelessWidget {
  final NewsFeed newsFeed;
  const FeedTile({
    Key? key,
    required this.newsFeed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(newsFeed.reviewerIcon),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                newsFeed.reviewer,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                newsFeed.title,
              ),
              Text(
                newsFeed.url,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          height: 60,
          width: 90,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(newsFeed.imageLink),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
