import 'package:flutter/material.dart';
import 'package:flutter_story_app/data/pref/pref_helper.dart';
import 'package:flutter_story_app/provider/auth_provider.dart';
import 'package:flutter_story_app/provider/story_provider.dart';
import 'package:flutter_story_app/routes/page_manager.dart';
import 'package:flutter_story_app/routes/router_delegate.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyRouterDelegate myRouterDelegate;
  late PrefHelper pref;
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    pref = PrefHelper();
    myRouterDelegate = MyRouterDelegate(pref);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(create: (context) => PageManager<String>()),
        ChangeNotifierProvider(create: (context) => StoryProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Router(
          routerDelegate: myRouterDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
