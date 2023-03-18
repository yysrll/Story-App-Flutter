import 'package:json_annotation/json_annotation.dart';

part 'add_stories_response.g.dart';

@JsonSerializable()
class AddStoriesResponse {
  bool error;
  String message;

  AddStoriesResponse({required this.error, required this.message});

  factory AddStoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$AddStoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddStoriesResponseToJson(this);
}
