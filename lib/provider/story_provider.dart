import 'package:flutter/material.dart';
import 'package:flutter_story_app/data/api/api_service.dart';
import 'package:flutter_story_app/data/pref/pref_helper.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/provider/result_state.dart';

class StoryProvider extends ChangeNotifier {
  late ApiService api;
  late PrefHelper pref;

  StoryProvider() {
    api = ApiService();
    pref = PrefHelper();
    getStories();
  }

  ResultState _state = ResultState.initial;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Story> _stories = [];
  List<Story> get stories => _stories;

  Future<void> getStories() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final token = await pref.getToken();

      final storiesResponse = await api.getStories(token);
      if (storiesResponse.listStory.isNotEmpty) {
        _state = ResultState.hasData;
      } else {
        _state = ResultState.noData;
        _message = 'Stories Not Found';
      }
      _stories = storiesResponse.listStory;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
