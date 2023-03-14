part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoaded extends PostState {
  PostLoaded(this.posts);
  final List<Post> posts;

  @override
  List<Object> get props => [posts];
}

class PostError extends PostState {
  PostError(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}
