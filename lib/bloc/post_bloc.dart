import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:random_post_generator/bloc/post_event.dart';
import 'package:random_post_generator/bloc/post_state.dart';
import 'package:random_post_generator/model/post.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const EmptyPost()) {
    on<GeneratePost>(_onGeneratePost);
    on<LoadingCompletePost>(_onLoadedPost);
    on<ResetPost>(_onResetPost);
  }

  void _onGeneratePost(GeneratePost event, Emitter<PostState> emit) async {
    emit(const LoadingPost());
    int randomId = Random().nextInt(200);
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts/$randomId");
    try {
      http.Response res = await http.get(url);
      var data = jsonDecode(res.body);
      Post post = Post.fromJson(data);
      add(
        LoadingCompletePost(
          title: post.title,
          body: post.body,
        ),
      );
    } catch (e) {
      print(e);
      add(const ResetPost(error: true));
    }
  }

  void _onLoadedPost(LoadingCompletePost event, Emitter<PostState> emit) {
    emit(
      LoadedPost(
        title: event.title,
        body: event.body,
      ),
    );
  }

  void _onResetPost(ResetPost event, Emitter<PostState> emit) {
    emit(EmptyPost(error: event.error));
  }
}
