import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_ceiba/domain/entities/post.dart';
import 'package:prueba_ceiba/domain/repositories/network_repositories.dart/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({required this.postRepository}) : super(PostInitial()) {
    on<FetchPostEvent>((event, emit) async {
      emit(PostLoadingState());
      try {
        final posts = await postRepository.fetchPost(event.id);
        emit(ListPostsData(list: posts));
      } catch (e) {
        emit(PostErrorState(message: e.toString()));
      }
    });
  }
}
