class Account {
  late String id;
  late String name;
  late String imagePath;
  late String selfIntroduction;
  late String userId;
  DateTime? createdTime;
  DateTime? updatedTime;

  Account({
    this.id = '',
    this.name = '',
    this.imagePath = '',
    this.selfIntroduction = '',
    this.userId = '',
    this.createdTime,
    this.updatedTime,
  });
}
