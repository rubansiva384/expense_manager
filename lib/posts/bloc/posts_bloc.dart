import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:expense_manager/posts/models/Post.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'posts_state.dart';
import 'posts_event.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final http.Client httpClient;

  PostsBloc(this.httpClient) : super(PostsInitial());

  @override
  Stream<PostsState> mapEventToState(
    PostsEvent event,
  ) async* {
    final currentState = state;
    if(event is PostsEventFetched && !_hasReachedMax(currentState)){
        if(currentState is PostsInitial){
          final posts = await _fetchPosts( 0 , 20);
          yield PostsSuccess(posts: posts , hasReachedMax: false);
        }else if(currentState is PostsSuccess){
          final posts = await _fetchPosts(currentState.posts.length, 20);
          yield posts.isEmpty ? currentState.copyWith(hasReachedMax: true) : PostsSuccess(posts: currentState.posts + posts);
        }
    }
  }


  Future<List<Post>> _fetchPosts(int start , int count) async {
    final response = await http.get("https://jsonplaceholder.typicode.com/posts?_start=$start&_limit=$count");
    if(response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((post) =>
          Post(
            id: post["id"] ,
            title:  post['title'],
            body: post['body']
          )
      ).toList();
    }else{
      throw Exception('error fetching posts');
    }
  }

  bool _hasReachedMax(PostsState currentState) {
    return currentState is PostsSuccess && currentState.hasReachedMax;
  }

}
