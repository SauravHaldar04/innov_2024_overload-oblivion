import 'package:flutter/material.dart';
import 'package:innovate_2/global/global_var.dart';
import 'package:innovate_2/screens/student_signup.dart';

class StudentLogin extends StatelessWidget {
  const StudentLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Login',
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
           
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 120.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Student Email',
                  floatingLabelStyle: TextStyle(color: Color.fromRGBO(31, 68, 255, 0.776)),
                  focusColor: Color.fromRGBO(31, 68, 255, 0.776),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(31, 68, 255, 0.776)),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  floatingLabelStyle: TextStyle(color: Color.fromRGBO(31, 68, 255, 0.776)),
                  focusColor: Color.fromRGBO(31, 68, 255, 0.776),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(31, 68, 255, 0.776)),
                  ),
                ),
              ),
              const SizedBox(height: 45.0),
              ElevatedButton(
                onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (_) => StudentDashboard())
                    //       );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(31, 68, 255, 0.776),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minimumSize: const Size(350.0, 45.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 45.0),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      height: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      height: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minimumSize: const Size(350.0, 45.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/Google.png'),
                                fit: BoxFit.cover),
                          )),
                      const SizedBox(
                        width: 49,
                      ),
                      const Text(
                        'Login with Google',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 19),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Not Registered yet? ',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const StudentSignup()
                          ));
                    },
                    child: const Text(
                      'Create an Account',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 98, 31, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}