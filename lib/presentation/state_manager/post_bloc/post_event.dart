part of 'post_bloc.dart';

sealed class PostEvent {}

class FetchPostEvent extends PostEvent {
  final int id;
  FetchPostEvent({required this.id});

 
}
class LoadingPostEvent extends PostEvent {}
 