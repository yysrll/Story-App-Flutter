import 'package:flutter_story_app/model/story.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_stories_response.g.dart';

@JsonSerializable()
class GetStoriesResponse {
  bool error;
  String message;
  List<Story> listStory;

  GetStoriesResponse(
      {required this.error, required this.message, required this.listStory});

  factory GetStoriesResponse.fromJson(Map<String, dynamic> json) => _$GetStoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetStoriesResponseToJson(this);
}
