import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Post {
  String title;
  String userName;
  String videoLink;
  String avatar;
  int upvote;
  int comments;
  int share;
  
  Post(
      {required this.title,
      required this.userName,
      required this.videoLink,
      required this.avatar,
      required this.upvote,
      required this.comments,
      required this.share,
      });

  factory Post.fromjson(Map<String, dynamic> json) {
    return Post(
        title: json['title'],
        userName: json['username'],
        videoLink: json['video_link'],
        avatar: json['picture_url'],
        upvote: json['upvote_count'],
        comments: json['comment_count'],
        share: json['share_count'],
        );
  }
}
