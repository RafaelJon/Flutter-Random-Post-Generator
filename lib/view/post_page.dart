import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_post_generator/bloc/post_bloc.dart';
import 'package:random_post_generator/bloc/post_event.dart';
import 'package:random_post_generator/bloc/post_state.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listenWhen: (previous, current) {
        print(current);
        if (current is EmptyPost && current.error) return true;

        return false;
      },
      listener: (context, state) {
        const snackbar = SnackBar(
          content: Text(
            'Error getting data',
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Random Post Generator'),
          ),
          body: SizedBox(
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (state is EmptyPost) ...[
                    const Text("Please generate post!"),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PostBloc>().add(const GeneratePost());
                      },
                      child: const Text("Generate"),
                    )
                  ],
                  if (state is LoadingPost) const Text("loading post to view"),
                  if (state is LoadedPost) ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<PostBloc>()
                                  .add(const GeneratePost());
                            },
                            child: const Text("Generate"),
                          ),
                          const Spacer(
                            flex: 2,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<PostBloc>().add(const ResetPost());
                            },
                            child: const Text("Reset"),
                          )
                        ],
                      ),
                    ),
                    Text(
                      state.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(state.body),
                  ]
                ]),
          ),
        );
      },
    );
  }
}
