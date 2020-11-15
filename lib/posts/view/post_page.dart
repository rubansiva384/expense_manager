import 'package:expense_manager/posts/bloc/posts_bloc.dart';
import 'package:expense_manager/posts/bloc/posts_event.dart';
import 'package:expense_manager/posts/view/post_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => PostsBloc(http.Client())..add(PostsEventFetched()),
    child: PostsView(),
    );
  }
}
