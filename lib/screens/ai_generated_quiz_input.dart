import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:innovate_2/global/global_var.dart';
import 'package:innovate_2/resources/database.dart';
import 'dart:convert';

import 'package:innovate_2/screens/ai_generated_page.dart';
import 'package:innovate_2/widgets/blue_button.dart';
import 'package:uuid/uuid.dart';

class AIQuizInputPage extends StatefulWidget {
  String quizId;
  AIQuizInputPage({super.key, required this.quizId});
  @override
  State<AIQuizInputPage> createState() => _AIQuizInputPageState();
}

class _AIQuizInputPageState extends State<AIQuizInputPage> {
  List<Map<String, dynamic>> topics = [];
  String selectedDifficulty = 'easy';
  int enteredTopicID = 0;
  DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    uploadQuizData(String question, String option1, String option2,
        String option3, String option4) async {
      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4
      };

      print("${widget.quizId}");
      databaseService.addQuestionData(questionMap, widget.quizId).then((value) {
        question = "";
        option1 = "";
        option2 = "";
        option3 = "";
        option4 = "";
        setState(() {});
      }).catchError((e) {
        print(e);
      });
    }

    //The Single child scroll view returns blank

    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlueButton(
                    onTap: () async {
                      final response = await http.get(Uri.parse(
                          'https://8892-59-164-67-218.ngrok-free.app/categories'));
                      if (response.statusCode == 200) {
                        final decodedResponse = json.decode(response.body);
                        setState(() {
                          topics =
                              List<Map<String, dynamic>>.from(decodedResponse);
                        });
                      } else {
                        print("Error");
                      }
                    },
                    text: 'Generate topics'),
                SizedBox(height: 16.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Text(
                            'ID',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                      rows: topics.map((topic) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                '${topic['id']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            DataCell(
                              Text(
                                topic['name'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Difficulty',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'easy',
                      child: Text('Easy'),
                    ),
                    DropdownMenuItem(
                      value: 'medium',
                      child: Text('Medium'),
                    ),
                    DropdownMenuItem(
                      value: 'hard',
                      child: Text('Hard'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedDifficulty = value!;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Topic ID',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      enteredTopicID = int.parse(value);
                    });
                  },
                ),
                SizedBox(height: 16.0),
                BlueButton(
                    onTap: () async {
                      final response = await http.post(
                        Uri.parse(
                            'https://8892-59-164-67-218.ngrok-free.app/quiz'),
                        body: json.encode(<String, dynamic>{
                          'difficulty': selectedDifficulty,
                          'topic_id': enteredTopicID,
                        }),
                        headers: <String, String>{
                          'Content-Type': 'application/json'
                        },
                      );
                      if (response.statusCode == 200) {
                        print(jsonDecode(response.body));
                        for (int i = 0; i < 5; i++) {
                          uploadQuizData(
                            jsonDecode(response.body)[i]['question'],
                            jsonDecode(response.body)[i]['correct_answer'],
                            jsonDecode(response.body)[i]["incorrect_answers"]
                                [0],
                            jsonDecode(response.body)[i]["incorrect_answers"]
                                [1],
                            jsonDecode(response.body)[i]["incorrect_answers"]
                                [2],
                          );
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AIQuizPlay()),
                        );
                      } else {
                        print("Error");
                      }
                    },
                    text: 'Generate Quiz')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
