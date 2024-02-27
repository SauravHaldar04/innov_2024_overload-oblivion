import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String uid;
  final String email;
  final String studentname;
  final String year;
  final String division;
  final String course;

  Student({
    required this.uid,
    required this.email,
    required this.studentname,
    required this.year,
    required this.division,
    required this.course,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'studentname': studentname,
      'email': email,
      'year': year,
      'division': division,
      'course': course,
    };
  }

  static Student fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    print(snapshot.toString());
    return Student(
      uid: snapshot['uid'],
      email: snapshot['email'],
      studentname: snapshot['studentname'],
      year: snapshot['year'],
      division: snapshot['division'],
      course: snapshot['course'],
    );
  }
}
