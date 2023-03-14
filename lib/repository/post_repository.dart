import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:socialverse/model/post_model.dart';

class PostRepository {
  String endPoint = 'https://api.socialverseapp.com/feed?page=1';
  Future<List<Post>> loadPosts() async {
    var response = await http.get(Uri.parse(endPoint));
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body)['posts'];
      return jsonData.map(((e) => Post.fromjson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
