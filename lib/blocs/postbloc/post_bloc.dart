import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socialverse/model/post_model.dart';
import 'package:socialverse/repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;
  PostBloc(this._postRepository) : super(PostLoading()) {
    on<LoadingPostEvent>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await _postRepository.loadPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
  }
}
