import 'package:flutter/material.dart';
import 'package:innovate_2/global/global_var.dart';
import 'package:innovate_2/screens/student_login.dart';
import 'package:innovate_2/screens/teacher_login.dart';

class UserTypeSelectionPage extends StatelessWidget {
  const UserTypeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'User Type Selection',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
        
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 10),
              const CircleAvatar(
                radius: 150,
                backgroundColor: Color.fromRGBO(255, 229, 180, 22),
                // foregroundImage: AssetImage('assets/images/sc9.png'),
              ),
            Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.primaryGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width - 16,
              height: (MediaQuery.of(context).size.height / 3.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StudentLogin(),
                          ),
                        );
                      },
                      child: const Text('I am a Student'),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TeacherLogin(),
                          ),
                        );
                      },
                      child: const Text('I am a Teacher'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
