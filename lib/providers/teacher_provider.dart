
import 'package:flutter/material.dart';
import 'package:innovate_2/models/teacher_model.dart';
import 'package:innovate_2/resources/auth_methods.dart';
import 'package:provider/provider.dart';
class TeacherProvider with ChangeNotifier {
  Teacher? _teacher;
  final AuthMethods _authMethods = AuthMethods();

  Teacher getUser() {
    return _teacher!;
  }

  Future<void> refreshTeacher() async {
    Teacher teacher = await _authMethods.getTeacherDetails();
    _teacher = teacher;
    print(_teacher!.teachername);
    notifyListeners();
  }
}
