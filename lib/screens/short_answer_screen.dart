import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:innovate_2/global/global_var.dart';

class ShortAnswerScreen extends StatefulWidget {
  const ShortAnswerScreen({Key? key}) : super(key: key);

  @override
  State<ShortAnswerScreen> createState() => _ShortAnswerScreenState();
}

class _ShortAnswerScreenState extends State<ShortAnswerScreen> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  final essayController = TextEditingController();
  int questionCount = 0;
  int answerCount = 0;
  List<TextField> questionTextFields = [];
  List<TextField> answerTextFields = [];
  String score = '';
  File? selectedPdf;

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    essayController.dispose();
    super.dispose();
  }

  Future essayViaScript() async {
    try {
      final response = await http.post(
        Uri.parse('${GlobalVariables.Url}/predict'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'text': essayController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Display success message
        print(jsonDecode(response.body));
         score = jsonDecode(response.body)['score'];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: Text(
                'Essay submitted successfully.\nYou have got score: $score'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
        setState(() {});
      } else {
        // Display error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Failed to submit question, answer, and essay.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Display error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'An error occurred while submitting question, answer, and essay.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future uploadViaScript() async {
    var dio = Dio();
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path ?? " ");
      String fileName = file.path.split('/').last;
      String filePath = file.path;
      FormData data = FormData.fromMap(
          {'file': await MultipartFile.fromFile(filePath, filename: fileName)});
      try {
        var response = await dio.post("${GlobalVariables.Url}/predict",
            data: data, onSendProgress: (int sent, int total) {
          print('$sent  $total');
        });
      } catch (e) {
        print(e.toString());
      }
    } else {
      print("Response is null");
    }
  }

  Future<void> submitQuestionAndAnswer() async {
    final question = questionController.text;
    final answer = answerController.text;
    final essay = essayController.text;

    try {
      final response = await http.post(
        Uri.parse('${GlobalVariables.Url}/grade'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'question': questionController.text,
          'answer': answerController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Display success message
        score = jsonDecode(response.body)['score'];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: Text(
                'Question, answer, and essay submitted successfully.\nYou have got score: $score'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
        setState(() {});
      } else {
        // Display error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Failed to submit question, answer, and essay.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Display error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'An error occurred while submitting question, answer, and essay.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false, // Allow only single file selection
    );

    if (result != null) {
      setState(() {
        selectedPdf = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Short Questions and Essays',
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
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Add greyish fill color
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: questionController,
                decoration: InputDecoration(
                  labelText: 'Question',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Enter the corresponding answer:',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Add greyish fill color
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: answerController,
                decoration: InputDecoration(
                  labelText: 'Answer',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Enter an essay:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Add greyish fill color
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: essayController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Essay',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Upload a PDF:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: pickPdf,
              child: const Text('Choose PDF'),
            ),
            if (selectedPdf != null)
              Text(
                'Selected PDF: ${selectedPdf!.path}',
                style: TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 32),
            Center(
              
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(17, 84, 218, 1), // Set button background color
                  shadowColor: Colors.black54, // Set button text color
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: (){submitQuestionAndAnswer();},
                child: const Text('Submit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19),),
              ),
            ),
            // const SizedBox(height: 16),
            // Text('Score: $score', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
