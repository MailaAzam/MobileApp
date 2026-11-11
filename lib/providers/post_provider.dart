import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class PostProvider extends ChangeNotifier {
  final PostService _service = PostService();

  List<Post> posts = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchPosts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners(); 

    try {
      posts = await _service.getPosts();
    } catch (e) {
      errorMessage = 'Something went wrong.\n$e';
    } finally {
      isLoading = false;
      notifyListeners(); 
    }
  }

  Future<bool> addPost(String title, String body) async {
    try {
      final newPost = await _service.createPost(
        Post(userId: 1, title: title, body: body),
      );
      posts.insert(0, newPost); 
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Add post failed: $e');
      return false;
    }
  }
}