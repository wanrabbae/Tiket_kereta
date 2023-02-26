// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

List<NewsModel> newsModelFromJson(String str) =>
    List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel {
  NewsModel({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.publish,
    required this.publishedAt,
  });

  int id;
  String image;
  String title;
  String description;
  int publish;
  DateTime publishedAt;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        description: json["description"],
        publish: json["publish"],
        publishedAt: DateTime.parse(json["published_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title": title,
        "description": description,
        "publish": publish,
        "published_at": publishedAt.toIso8601String(),
      };
}
