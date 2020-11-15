import 'package:expense_manager/posts/view/post_page.dart';
import 'package:flutter/material.dart';

class ScrollApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("home"),
        ),
        body: PostPage(),
      ),
    );
  }
}
