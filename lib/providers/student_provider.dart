
import 'package:flutter/material.dart';
import 'package:innovate_2/models/student_model.dart';
import 'package:innovate_2/resources/auth_methods.dart';

class StudentProvider with ChangeNotifier {
  Student? _student;
  final AuthMethods _authMethods = AuthMethods();

  Student getUser() {
    return _student!;
  }

  Future<void> refreshStudent() async {
    Student student = await _authMethods.getStudentDetails();
    _student = student;
    print(_student!.studentname);
    notifyListeners();
  }
}