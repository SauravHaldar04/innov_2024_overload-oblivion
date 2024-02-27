import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:innovate_2/screens/ai_generated_page.dart';

class AIQuizInputPage extends StatefulWidget {
  @override
  State<AIQuizInputPage> createState() => _AIQuizInputPageState();
}

class _AIQuizInputPageState extends State<AIQuizInputPage> {
  List<Map<String, dynamic>> topics = [];
  String selectedDifficulty = 'easy';
  int enteredTopicID = 0;

  @override
  Widget build(BuildContext context) {
    //The Single child scroll view returns blank

    return Scaffold(
      appBar: AppBar(
        title: Text('AI Generated Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final response = await http.get(Uri.parse(
                        'https://9dc9-59-164-67-218.ngrok-free.app/categories'));
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
                  child: Text('Generate Topics'),
                ),
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
                ElevatedButton(
                  onPressed: () async {
                    final response = await http.post(
                      Uri.parse(
                          'https://9dc9-59-164-67-218.ngrok-free.app/quiz'),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AIQuizPlay()),
                      );
                    } else {
                      print("Error");
                    }
                  },
                  child: Text('Generate'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
