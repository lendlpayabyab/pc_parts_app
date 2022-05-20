class NewsFeed{
  String reviewer;
  String reviewerIcon;
  String imageLink;
  String title;
  String url;

  NewsFeed({
    required this.reviewer,
    required this.reviewerIcon,
    required this.imageLink,
    required this.title,
    required this.url,
  });

  factory NewsFeed.fromJson(Map<String, dynamic> json) {
    return NewsFeed(
      reviewer: json['reviewer'] ?? '',
      reviewerIcon: json['reviewerIcon'] ?? '',
      imageLink: json['imageLink'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
    );
  }
}