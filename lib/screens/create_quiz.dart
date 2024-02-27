import 'package:flutter/material.dart';
import 'package:innovate_2/global/global_var.dart';
import 'package:innovate_2/models/teacher_model.dart';
import 'package:innovate_2/providers/teacher_provider.dart';
import 'package:innovate_2/resources/database.dart';
import 'package:innovate_2/screens/add_question.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  String? quizImgUrl, quizTitle, quizDesc, id;

  bool isLoading = false;
  String? quizId;

  createQuiz(String course, String year, String division) {
    quizId = Uuid().v1();
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> quizData = {
        "quizImgUrl": quizImgUrl!,
        "quizTitle": quizTitle!,
        "quizDesc": quizDesc!,
        "id": quizId!,
      };

      databaseService
          .addQuizData(quizData, quizId!, course, year, division)
          .then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AddQuestion(quizId!)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Teacher _teacher =
        Provider.of<TeacherProvider>(context).getUser();
    String selectedValue = 'FE';
    String selectedDivision = 'C1';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        title: Text("Quiz"),

        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                validator: (val) =>
                    val!.isEmpty ? "Enter Quiz Image Url" : null,
                decoration:
                    InputDecoration(hintText: "Quiz Image Url (Optional)"),
                onChanged: (val) {
                  quizImgUrl = val;
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Quiz Title" : null,
                decoration: InputDecoration(hintText: "Quiz Title"),
                onChanged: (val) {
                  quizTitle = val;
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (val) =>
                    val!.isEmpty ? "Enter Quiz Description" : null,
                decoration: InputDecoration(hintText: "Quiz Description"),
                onChanged: (val) {
                  quizDesc = val;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Select a year'),
              Container(
                height: 70,
                width: 80,
                child: DropdownButton<String>(
                  elevation: 6,
                  value: selectedValue,
                  items: const <DropdownMenuItem<String>>[
                    DropdownMenuItem(
                      value: 'FE',
                      child: Text("FE"),
                    ),
                    DropdownMenuItem(
                      value: "SE",
                      child: Text("SE"),
                    ),
                    DropdownMenuItem(
                      value: "TE",
                      child: Text("TE"),
                    ),
                    DropdownMenuItem(
                      value: "BE",
                      child: Text("BE"),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                      // Perform actions based on the selected value
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Select a Division'),
              Container(
                height: 70,
                width: 80,
                child: DropdownButton<String>(
                  elevation: 6,
                  value: selectedDivision,
                  items: const <DropdownMenuItem<String>>[
                    DropdownMenuItem(
                      value: "C1",
                      child: Text("C1"),
                    ),
                    DropdownMenuItem(
                      value: "C2",
                      child: Text("C2"),
                    ),
                    DropdownMenuItem(
                      value: "DS1",
                      child: Text("DS1"),
                    ),
                    DropdownMenuItem(
                      value: "Mech1",
                      child: Text("Mech1"),
                    ),
                    DropdownMenuItem(
                      value: "Mech2",
                      child: Text("Mech2"),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDivision = newValue!;
                      // Perform actions based on the selected value
                    });
                  },
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  createQuiz(_teacher.course,selectedValue,selectedDivision);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Create Quiz",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
