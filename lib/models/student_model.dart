import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String uid;
  final String email;
  final String studentname;
  final String year;
  final String division;
  final String course;
  final List quizID;

  Student({
    required this.uid,
    required this.email,
    required this.studentname,
    required this.year,
    required this.division,
    required this.course,
    required this.quizID ,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'studentname': studentname,
      'email': email,
      'year': year,
      'division': division,
      'course': course,
      'quizData':quizID
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
      quizID: snapshot['quizData']
    );
  }
}
