import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class GeneratePost extends PostEvent {
  const GeneratePost() : super();
}

class LoadingCompletePost extends PostEvent {
  const LoadingCompletePost({
    required this.title,
    required this.body,
  }) : super();

  final String title;
  final String body;

  @override
  List<Object?> get props => [title, body];
}

class ResetPost extends PostEvent {
  const ResetPost() : super();
}
