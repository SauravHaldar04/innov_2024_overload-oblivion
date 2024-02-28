import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:http/http.dart' as http;
import 'package:innovate_2/screens/student_homepage.dart';


class chatHelp2 extends StatefulWidget {
  const chatHelp2({super.key});

  @override
  State<chatHelp2> createState() => _chatHelp2State();
}

class _chatHelp2State extends State<chatHelp2> {
  ChatUser myself = ChatUser(id: '1',firstName: 'Shlok');
  ChatUser bot = ChatUser(id: '2',firstName: 'Chanakya');

  List <ChatMessage> allMessages=[];
  List <ChatUser> typing=[];
  final ourUrl='https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyDN75ihrCa2m0elIiNZZqkhfjDfK7k_7wY';
  final header = {
    "Content-Type":"application/json"
  };

  getdata(ChatMessage m) async {
    typing.add(bot);
    allMessages.insert(0, m);

    setState(() {});
    var data = {"contents":[{"parts":[{"text":m.text}]}]};
    await http.post(Uri.parse(ourUrl),headers: header,body: jsonEncode(data)).then((value) {
      if(value.statusCode==200){
        var result=jsonDecode(value.body);
        print(result['candidates'][0]['content']['parts'][0]['text']);

        ChatMessage m1=ChatMessage(text: result['candidates'][0]['content']['parts'][0]['text'],user: bot, createdAt: DateTime.now());
        allMessages.insert(0, m1);
        setState(() {});
      } else {
        print("error occured");
      }
    }).catchError((e) {});

    typing.remove(bot);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chanakya ChatHelp'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const StudentHomepage() ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          
          DashChat(
            typingUsers: typing,
            currentUser: myself, 
            onSend: (ChatMessage m){
              getdata(m);
            },
            messages: allMessages,
          ),
        ],
      ),
    );
  }
}