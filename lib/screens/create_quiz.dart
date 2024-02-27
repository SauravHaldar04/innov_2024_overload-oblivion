import 'package:flutter/material.dart';
import 'package:innovate_2/global/global_var.dart';
import 'package:innovate_2/models/teacher_model.dart';
import 'package:innovate_2/providers/teacher_provider.dart';
import 'package:innovate_2/resources/database.dart';
import 'package:innovate_2/screens/add_question.dart';
import 'package:innovate_2/widgets/blue_button.dart';
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
  String selectedValue = 'FE';
  String selectedDivision = 'C1';
  String selectedCourse = "Economics";
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
    // Teacher _teacher =
    //     Provider.of<TeacherProvider>(context).getUser();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Enter Quiz Details',
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.primaryGradient),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 16), // Add vertical spacing
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align fields to the left
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
              const SizedBox(
                height: 16, // Add vertical spacing
              ),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Quiz Title" : null,
                decoration: const InputDecoration(hintText: "Quiz Title"),
                onChanged: (val) {
                  quizTitle = val;
                },
              ),
              const SizedBox(
                height: 16, // Add vertical spacing
              ),
              TextFormField(
                validator: (val) =>
                    val!.isEmpty ? "Enter Quiz Description" : null,
                decoration: const InputDecoration(hintText: "Quiz Description"),
                onChanged: (val) {
                  quizDesc = val;
                },
              ),
              SizedBox(
                height: 16, // Add vertical spacing
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
              SizedBox(
                height: 16, // Add vertical spacing
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
              Text("Select Course"),
              Container(
                height: 70,
                child: DropdownButton<String>(
                  elevation: 6,
                  value: selectedCourse,
                  items: const <DropdownMenuItem<String>>[
                    DropdownMenuItem(
                      value: "Economics",
                      child: Text("Economics"),
                    ),
                    DropdownMenuItem(
                      value: "History",
                      child: Text("History"),
                    ),
                    DropdownMenuItem(
                      value: "Computer Science",
                      child: Text("Computer Science"),
                    ),
                    DropdownMenuItem(
                      value: "Political Science",
                      child: Text("Political Science"),
                    ),
                    DropdownMenuItem(
                      value: "Literature",
                      child: Text("Literature"),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCourse = newValue!;
                      // Perform actions based on the selected value
                    });
                  },
                ),
              ),
              Spacer(),
              BlueButton(
                onTap: () {
                  createQuiz(selectedCourse, selectedValue, selectedDivision);
                },
                text: "Create Quiz",
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
