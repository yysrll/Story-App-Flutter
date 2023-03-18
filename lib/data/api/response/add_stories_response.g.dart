// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_stories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddStoriesResponse _$AddStoriesResponseFromJson(Map<String, dynamic> json) =>
    AddStoriesResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$AddStoriesResponseToJson(AddStoriesResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
    };
