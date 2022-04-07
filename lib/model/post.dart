class Post {
  late String id;
  late String content;
  late String postAccountId;
  DateTime? createdTime;

  Post({
    this.id = '',
    this.content = '',
    this.postAccountId = '',
    this.createdTime,
  });
}
