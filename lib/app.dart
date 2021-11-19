import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_post_generator/bloc/post_bloc.dart';
import 'package:random_post_generator/view/post_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter random post gerenator',
      home: BlocProvider(
        create: (BuildContext context) => PostBloc(),
        child: const PostPage(),
      ),
    );
  }
}
