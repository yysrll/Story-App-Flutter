import 'package:json_annotation/json_annotation.dart';

part 'story.g.dart';

@JsonSerializable()
class Story {
  String id;
  String name;
  String description;
  String photoUrl;
  String createdAt;
  num? lat;
  num? lon;

  Story(
      {required this.id,
      required this.name,
      required this.description,
      required this.photoUrl,
      required this.createdAt,
      this.lat,
      this.lon});

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);
}
