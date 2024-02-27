import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:innovate_2/global/global_var.dart';
import 'package:innovate_2/providers/teacher_provider.dart';
import 'package:innovate_2/resources/database.dart';
import 'package:innovate_2/screens/create_quiz.dart';
import 'package:innovate_2/screens/quiz_play.dart';
import 'package:innovate_2/screens/user_type_selec.dart';
import 'package:innovate_2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class TeacherHomepage extends StatefulWidget {
  const TeacherHomepage({super.key});

  @override
  State<TeacherHomepage> createState() => _TeacherHomepageState();
}

class _TeacherHomepageState extends State<TeacherHomepage> {
 Stream? quizStream;
 bool isCreateMode = true;

  DatabaseService databaseService = new DatabaseService();

  Widget quizList() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Quiz").snapshots(),
              builder: (context, snapshot) {
                return snapshot.data == null
                    ? Container()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return QuizTile(
                            noOfQuestions: snapshot.data!.docs.length,
                            imageUrl:
                                snapshot.data!.docs[index].data()['quizImgUrl'],
                            title:
                                snapshot.data!.docs[index].data()['quizTitle'],
                            description:
                                snapshot.data!.docs[index].data()['quizDesc'],
                            id: snapshot.data!.docs[index].data()['id'],
                          );
                        });
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizData().then((value) {
      quizStream = value;
      addData();
      setState(() {});
    });
    super.initState();
  }

  void addData() async {
    TeacherProvider _teacherProvider = Provider.of(context, listen: false);
    await _teacherProvider.refreshTeacher();
  }

  @override
  Widget build(BuildContext context) {
    bool isCreateMode = true;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromRGBO(99, 151, 255, 1), Color.fromRGBO(31, 68, 255, 1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'Homepage',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(99, 151, 255, 1), Color.fromRGBO(31, 68, 255, 1)
                        ],
                        stops: [0.1, 1],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Sign Out'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserTypeSelectionPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
      body: quizList(),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), // Create a notch for FAB
        child: Row(
          children: [
            // Other bottom nav items if any
            Spacer(),
            Container(
              width: 48,
              height: 48,
              child: IconButton(
                onPressed: () => setState(() => isCreateMode = true),
                icon: Icon(Icons.create,size:39),
                color: isCreateMode ? Colors.blue : Colors.grey, // Highlight active button
              ),
            ),
            SizedBox(width: 96),
            Container(
              width: 48,
              height: 48,
              child: IconButton(
                onPressed: () => setState(() => isCreateMode = false),
                icon: Icon(Icons.get_app,size:39),
                color: !isCreateMode ? Colors.blue : Colors.grey,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isCreateMode) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateQuiz()));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AIQuizInputPage())
                );
          }
        },
        child: Icon(isCreateMode ? Icons.add : Icons.document_scanner), // Change icon based on mode
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imageUrl, title, id, description;
  final int noOfQuestions;

  QuizTile(
      {required this.title,
      required this.imageUrl,
      required this.description,
      required this.id,
      required this.noOfQuestions});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QuizPlay(id)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                color: Colors.black26,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        description,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
