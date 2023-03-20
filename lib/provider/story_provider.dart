import 'package:flutter/material.dart';
import 'package:flutter_story_app/data/api/api_service.dart';
import 'package:flutter_story_app/data/pref/pref_helper.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/provider/result_state.dart';
import 'package:image_picker/image_picker.dart';

class StoryProvider extends ChangeNotifier {
  late ApiService api;
  late PrefHelper pref;

  StoryProvider() {
    api = ApiService();
    pref = PrefHelper();
  }

  ResultState _state = ResultState.initial;

  ResultState get state => _state;

  String _message = '';

  String get message => _message;

  int? pageItems = 1;
  int sizeItem = 10;

  final List<Story> _stories = [];

  List<Story> get stories => _stories;

  bool _isUploadLoading = false;

  bool get isUploadLoading => _isUploadLoading;

  Future<void> getStories() async {
    try {
      if (pageItems == 1) {
        _stories.clear();
        _state = ResultState.loading;
        notifyListeners();
      }

      final token = await pref.getToken();

      final storiesResponse = await api.getStories(token, pageItems!, sizeItem);
      if (storiesResponse.listStory.isNotEmpty) {
        _state = ResultState.hasData;
      } else {
        if (pageItems == 1) {
          _state = ResultState.noData;
          _message = 'Stories Not Found';
        }
      }
      _stories.addAll(storiesResponse.listStory);

      if (storiesResponse.listStory.length < sizeItem) {
        pageItems = null;
      } else {
        pageItems = pageItems! + 1;
      }

      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  Future<List<Story>> getStoriesWithLocation() async {
    final token = await pref.getToken();
    final stories = await api.getStories(token, 1, 10, location: 1);
    return stories.listStory;
  }

  Future<bool> uploadStory(List<int> bytes, String fileName, String description,
      {double? latitude, double? longitude}) async {
    var isSuccess = false;
    try {
      _isUploadLoading = true;
      notifyListeners();

      final token = await pref.getToken();
      final uploadResponse = await api.uploadStory(
          bytes, fileName, description, token,
          latitude: latitude, longitude: longitude);
      _message = uploadResponse.message;
      isSuccess = !uploadResponse.error;
    } catch (e) {
      _message = e.toString();
    } finally {
      _isUploadLoading = false;
      notifyListeners();
    }
    return isSuccess;
  }

  XFile? imageFile;
  String? imagePath;

  void setImageFile(XFile? file) {
    imageFile = file;
    notifyListeners();
  }

  void setImagePath(String? path) {
    imagePath = path;
    notifyListeners();
  }
}
