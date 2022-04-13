//投稿をFirestoreに保存可能に

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertwitter/model/post.dart';

class PostFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference posts =
      _firestoreInstance.collection('posts');
  static Future<dynamic> addPost(Post newPost) async {
    try {
      final CollectionReference _userPosts = _firestoreInstance
          .collection('users')
          .doc(newPost.postAccountId)
          .collection('my_posts');
      var result = await posts.add({
        'content': newPost.content,
        'post account id': newPost.postAccountId,
        'created_time': Timestamp.now()
      });
      _userPosts
          .doc(result.id)
          .set({'post id': result.id, 'created time': Timestamp.now});
      print('投稿完了');
      return true;
    } on FirebaseException catch (e) {
      print('投稿エラー: $e');
      return false;
    }
  }
}
