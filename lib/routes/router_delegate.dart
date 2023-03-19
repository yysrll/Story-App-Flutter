import 'package:flutter/material.dart';
import 'package:flutter_story_app/data/pref/pref_helper.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/screen/screen.dart';
import 'package:flutter_story_app/widgets/widget.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final PrefHelper pref;

  MyRouterDelegate(this.pref) : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    isLoggedIn = await pref.isLoggedIn();
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;

  Story? selectedStory;
  bool isPostScreen = false;
  bool isShowLogoutDialog = false;
  bool isMapScreen = false;

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }
    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        isRegister = true;
        selectedStory = null;
        isPostScreen = false;
        isShowLogoutDialog = false;
        isMapScreen = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    /* Do Nothing */
  }

  List<Page> get _splashStack => const [
        MaterialPage(
          key: ValueKey('SplashScreen'),
          child: SplashScreen(),
        ),
      ];

  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey('LoginPage'),
          child: LoginScreen(
            onLogin: () {
              isLoggedIn = true;
              notifyListeners();
            },
            onRegister: () {
              isRegister = true;
              notifyListeners();
            },
          ),
        ),
        if (isRegister == true)
          MaterialPage(
            key: const ValueKey('RegisterPage'),
            child: RegisterScreen(
              onRegister: () {
                isRegister = false;
                notifyListeners();
              },
              onLogin: () {
                isRegister = false;
                notifyListeners();
              },
            ),
          ),
      ];

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey('HomePage'),
          child: HomeScreen(
            onLogout: () {
              isShowLogoutDialog = true;
              notifyListeners();
            },
            onDetail: (Story story) {
              selectedStory = story;
              notifyListeners();
            },
            onPost: () {
              isPostScreen = true;
              notifyListeners();
            },
            onMap: () {
              isMapScreen = true;
              notifyListeners();
            },
          ),
        ),
        if (isShowLogoutDialog)
          LogoutAlertDialog(
            onLogoutSuccess: () {
              isShowLogoutDialog = false;
              isLoggedIn = false;
              notifyListeners();
            },
            onLogoutFailed: () {
              isShowLogoutDialog = false;
              notifyListeners();
            },
          ),
        if (selectedStory != null)
          MaterialPage(
            key: const ValueKey('DetailPage'),
            child: DetailScreen(story: selectedStory!),
          ),
        if (isPostScreen)
          MaterialPage(
            key: const ValueKey('AddStoryPage'),
            child: AddStoryScreen(
              onSubmit: () {
                isPostScreen = false;
                notifyListeners();
              },
            ),
          ),
        if (isMapScreen)
          const MaterialPage(key: ValueKey("MapPage"), child: MapScreen()),
      ];
}
