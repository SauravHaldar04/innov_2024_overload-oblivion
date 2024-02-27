import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher {
  final String uid;
  final String email;
  final String teachername;
  final String course;
  final String designation;

  Teacher({
    required this.uid,
    required this.email,
    required this.teachername,
    required this.designation,
    required this.course,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'teachername': teachername,
      'email': email,
      'designation': designation,
      'course': course,
    };
  }

  static Teacher fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    print(snapshot.toString());
    return Teacher(
      uid: snapshot['uid'],
      email: snapshot['email'],
      teachername: snapshot['teachername'],
      designation: snapshot['designation'],
      course: snapshot['course'],
    );
  }
}
