import 'package:expense_manager/posts/models/Post.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsSuccess extends PostsState{
  final List<Post> posts;
  final bool hasReachedMax;

  PostsSuccess({this.posts , this.hasReachedMax });

  PostsSuccess copyWith({List<Post> posts , bool hasReachedMax}){
    return PostsSuccess(posts: posts ?? this.posts
      , hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }
}

class PostsFailure extends PostsState{}

