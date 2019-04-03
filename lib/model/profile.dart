import 'package:firebase_database/firebase_database.dart';

class Profile {
  String key;
  String subject;
  bool completed;
  String userId;

  Profile(this.subject, this.userId, this.completed);

  Profile.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        userId = snapshot.value["userId"],
        subject = snapshot.value["subject"],
        completed = snapshot.value["completed"];

  toJson() {
    return {
      "userId": userId,
      "subject": subject,
      "completed": completed,
    };
  }
}