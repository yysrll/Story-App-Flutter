import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final String title;
  final List<Widget>? action;
  final Widget? floatingActiopnButton;
  final Widget body;

  const MainLayout({
    Key? key,
    required this.title,
    this.action,
    this.floatingActiopnButton,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        actions: action,
      ),
      floatingActionButton: floatingActiopnButton,
      body: SafeArea(
        child: body,
      ),
    );
  }
}
