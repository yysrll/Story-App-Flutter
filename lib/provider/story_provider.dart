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

  List<Story> _stories = [];

  List<Story> get stories => _stories;

  bool _isUploadLoading = false;

  bool get isUploadLoading => _isUploadLoading;

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

  Future<bool> uploadStory(
    List<int> bytes,
    String fileName,
    String description,
  ) async {
    var isSuccess = false;
    try {
      _isUploadLoading = true;
      notifyListeners();

      final token = await pref.getToken();
      final uploadResponse =
          await api.uploadStory(bytes, fileName, description, token);
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
