import 'package:flutter/material.dart';
import 'package:innovate_2/screens/chat_help2.dart';

class ChatLoadScreen extends StatefulWidget {
  const ChatLoadScreen({super.key});

  @override
  State<ChatLoadScreen> createState() => _ChatLoadScreenState();
}

class _ChatLoadScreenState extends State<ChatLoadScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds and then navigate to ChatHelp2 screen
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const chatHelp2()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // You can customize your splash screen UI here
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Help'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.chat,
                size: 50,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Chat Help',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(), // Add circular progress indicator
          ],
        ),
      ),
    );
  }
}
