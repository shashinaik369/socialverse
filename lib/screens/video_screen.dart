import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:socialverse/blocs/postbloc/post_bloc.dart';
import 'package:socialverse/model/post_model.dart';
import 'package:socialverse/screens/video_player.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  List<Post> posts = [];
  bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PostLoaded) {
            posts = state.posts;

            return GestureDetector(
              onTap: () {
                setState(() {
                  isPlaying = !isPlaying;
                });
              },
              child: PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return FeedItem(
                      url: posts[index].videoLink,
                      title: posts[index].title,
                      userName: posts[index].userName,
                      avatar: posts[index].avatar,
                     likes: posts[index].upvote,
                     comments: posts[index].comments,
                     share: posts[index].share,
                    );
                  }),
            );
          }
          return const Center(child: Text('Something Went Wrong'));
        },
      ),
    );
  }
}
