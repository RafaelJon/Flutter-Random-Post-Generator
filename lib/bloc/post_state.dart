import 'package:equatable/equatable.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class EmptyPost extends PostState {
  const EmptyPost() : super();
}

class LoadingPost extends PostState {
  const LoadingPost() : super();
}

class LoadedPost extends PostState {
  const LoadedPost({
    required this.title,
    required this.body,
  }) : super();

  final String title;
  final String body;

  @override
  List<Object?> get props => [title, body];
}
