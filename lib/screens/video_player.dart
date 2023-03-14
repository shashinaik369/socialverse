import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';

class FeedItem extends StatefulWidget {
  //Url to play video
  final String url;
  final String title;
  final String userName;
  final String avatar;

  final int likes;
  final int comments;
  final int share;
  const FeedItem({
    Key? key,
    required this.url,
    required this.title,
    required this.userName,
    required this.avatar,
    required this.likes,
    required this.comments,
    required this.share,
  }) : super(key: key);

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  //player controller
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    //initialize player
    initializePlayer(widget.url);
  }

//Initialize Video Player
  void initializePlayer(String url) async {
    final fileInfo = await checkCacheFor(url);
    if (fileInfo == null) {
      _controller = VideoPlayerController.network(url);
      _controller!.initialize().then((value) {
        cachedForUrl(url);
        setState(() {
          _controller!.play();
        });
      });
    } else {
      final file = fileInfo.file;
      _controller = VideoPlayerController.file(file);
      _controller!.initialize().then((value) {
        setState(() {
          _controller!.play();
        });
      });
    }
  }

//: check for cache
  Future<FileInfo?> checkCacheFor(String url) async {
    final FileInfo? value = await DefaultCacheManager().getFileFromCache(url);
    return value;
  }

//:cached Url Data
  void cachedForUrl(String url) async {
    await DefaultCacheManager().getSingleFile(url).then((value) {
      print('downloaded successfully done for $url');
    });
  }

//:Dispose
  @override
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
    }
    super.dispose();
  }

  //profile photo
  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 65,
      height: 65,
      child: Stack(children: [
        Positioned(
          left: 5,
          child: Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (_controller == null)
        ? const Center(
            child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator()))
        : ((_controller!.value.isInitialized)
            ? InkWell(
                onTap: () {
                  setState(() {
                    _controller!.value.isPlaying
                        ? _controller!.pause()
                        : _controller!.play();
                  });
                },
                child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      VideoPlayer(_controller!),
                      VideoProgressIndicator(_controller!,
                          allowScrubbing: true),
                      Positioned(
                        left: 14,
                        bottom: 50,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildProfile(widget.avatar),
                            const SizedBox(
                              width: 06,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '@' + widget.userName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    widget.title,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        right: 10,
                        child: Column(
                          children: [
                            ReUseWidget(
                                no: widget.likes.toString(),
                                icon: Icons.thumb_up),
                            const SizedBox(
                              height: 10,
                            ),
                            ReUseWidget(
                                no: widget.comments.toString(),
                                icon: Icons.comment),
                            const SizedBox(
                              height: 10,
                            ),
                            ReUseWidget(
                                no: widget.share.toString(), icon: Icons.share),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    ])),
              )
            : const Text('Loading...'));
  }
}

class ReUseWidget extends StatelessWidget {
  ReUseWidget({super.key, required this.no, required this.icon});
  String no;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 35,
          color: Colors.white,
        ),
        const SizedBox(height: 7),
        Text(
          no,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
