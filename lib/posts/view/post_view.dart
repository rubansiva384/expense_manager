import 'package:expense_manager/posts/bloc/posts_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_manager/posts/bloc/posts_state.dart';
import 'package:expense_manager/posts/bloc/posts_event.dart';

class PostsView extends StatefulWidget {
  @override
  _PostsViewState createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  final _scrollThreshold = 200.0;
  PostsBloc _postsBloc;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postsBloc = BlocProvider.of<PostsBloc>(context);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postsBloc.add(PostsEventFetched());
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: missing_return
    return BlocBuilder<PostsBloc , PostsState>(builder: (context , state){
      if(state is PostsInitial){
        return Center(child: CircularProgressIndicator(),);
      }

      if (state is PostsSuccess){
        return ListView.builder(
          itemBuilder: (context , index){
            if(index >= state.posts.length )
              return BottomLoader();
            else {
              final post = state.posts[index];
              return ListTile(leading: Text("${post.id}"), title: Text("${post.title}"),);
            }
          },
          itemCount: state.hasReachedMax ? state.posts.length : state.posts.length + 1,
          controller: _scrollController,
        );
      }

      if(state is PostsFailure){
        return Center(child: Text("posts fetching failed"),);
      }

    });
  }
}

class BottomLoader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          width: 33,
            height: 33,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
