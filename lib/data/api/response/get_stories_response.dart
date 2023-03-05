import 'package:flutter_story_app/model/story.dart';

class GetStoriesResponse {
  bool error;
  String message;
  List<Story> listStory;

  GetStoriesResponse(
      {required this.error, required this.message, required this.listStory});

  factory GetStoriesResponse.fromJson(Map<String, dynamic> json) =>
      GetStoriesResponse(
        error: json['error'],
        message: json['message'],
        listStory:
            List<Story>.from(json['listStory'].map((e) => Story.fromJson(e))),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'listStory': List<dynamic>.from(listStory.map((e) => e.toJson())),
      };
}
