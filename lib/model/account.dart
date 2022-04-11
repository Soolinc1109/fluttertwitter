import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  late String id;
  late String name;
  late String imagePath;
  late String selfIntroduction;
  late String userId;
  Timestamp? createdTime;
  Timestamp? updatedTime;

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
