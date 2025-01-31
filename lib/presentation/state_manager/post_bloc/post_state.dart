part of 'post_bloc.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoadingState extends PostState {}

class ListPostsData extends PostState {
  final List<Post> list;

  ListPostsData({required this.list});
}

class PostErrorState extends PostState {
  final String message;

  PostErrorState({required this.message});
}