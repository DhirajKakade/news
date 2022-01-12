import 'package:intl/intl.dart';

class News {
  final String urlToImage;
  final String title;
  final String description;
  final String publishedAt;

  News({
    required this.urlToImage,
    required this.title,
    required this.description,
    required this.publishedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    String publishedAt = json['publishedAt'] ?? '';
    var dateValue =
        DateFormat("yyyy-MM-ddTHH:mm:ssZ").parseUTC(publishedAt).toLocal();
    String formattedDate = DateFormat("dd MMM yyyy hh:mm a").format(dateValue);

    return News(
      urlToImage: json['urlToImage'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      publishedAt: formattedDate,
    );
  }
}
