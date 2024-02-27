import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
            import 'dart:convert';

class AIQuizInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Generated Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            

            // ...

            ElevatedButton(
              onPressed: () async {
                final response = await http.get(Uri.parse('https://84ef-2409-4080-1207-ae34-dcdd-1905-50ef-7b4c.ngrok-free.app/categories'));
                if (response.statusCode == 200) {
                  final decodedResponse = json.decode(response.body);
                  final result = decodedResponse.toString();
                  print(result);
                 
                } else {
                  print("Error");
                }
              },
              child: Text('Generate Topics'),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Difficulty',
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(
                  value: 'Easy',
                  child: Text('Easy'),
                ),
                DropdownMenuItem(
                  value: 'Medium',
                  child: Text('Medium'),
                ),
                DropdownMenuItem(
                  value: 'Hard',
                  child: Text('Hard'),
                ),
              ],
              onChanged: (value) {
                // Add your logic for handling the selected difficulty here
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Topic ID',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Add your logic for handling the entered topic ID here
              },
            ),
          ],
        ),
      ),
    );
  }
}
 