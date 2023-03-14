import 'package:flutter/material.dart';
import 'package:socialverse/screens/video_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/postbloc/post_bloc.dart';
import 'repository/post_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostRepository(),
      child: BlocProvider(
        create: (context) => PostBloc(RepositoryProvider.of<PostRepository>(context))..add(LoadingPostEvent()),
        child: const MaterialApp(
          home: VideoScreen(),
        ),
      ),
    );
  }
}
