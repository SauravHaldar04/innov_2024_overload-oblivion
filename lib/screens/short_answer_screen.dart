import 'package:flutter/material.dart';
import 'package:innovate_2/global/global_var.dart';

class ShortAnswerScreen extends StatefulWidget {
  const ShortAnswerScreen({Key? key}) : super(key: key);

  @override
  State<ShortAnswerScreen> createState() => _ShortAnswerScreenState();
}

class _ShortAnswerScreenState extends State<ShortAnswerScreen> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  int questionCount = 0;
  int answerCount = 0;
  List<TextField> questionTextFields = [];
  List<TextField> answerTextFields = [];

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student SignUp',
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.primaryGradient),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            const SizedBox(height: 32),
            Text('Enter a question:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: questionController,
              decoration: InputDecoration(
                labelText: 'Question',
              ),
            ),
            const SizedBox(height: 16),
            Text('Enter the corresponding answer:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: answerController,
              decoration: InputDecoration(
                labelText: 'Answer',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                  
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}