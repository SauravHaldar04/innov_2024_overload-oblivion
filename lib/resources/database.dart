import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid = ''});

  Future<void> addData(userData) async {
    FirebaseFirestore.instance
        .collection("users")
        .add(userData)
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await FirebaseFirestore.instance.collection("users").snapshots();
  }

  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId,
      String course, String year, String division) async {
    User teacher = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e);
    });
    await FirebaseFirestore.instance
        .collection('students')
        .where('course', isEqualTo: course)
        .where('year', isEqualTo: year)
        .where('division', isEqualTo: division)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({
          'quizID': FieldValue.arrayUnion([quizId])
        });
      });
    });
    await FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacher.uid)
        .update({
      'quizID': FieldValue.arrayUnion([quizId])
    });
  }

  Future<void> addQuestionData(quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .add(quizData)
        .catchError((e) {
      print(e);
    });
  }

  getQuizData() async {
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  getQuestionData(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .get();
  }
}
