import 'package:flutter/material.dart';
import 'package:innovate_2/global/global_var.dart';
import 'package:innovate_2/resources/auth_methods.dart';
import 'package:innovate_2/screens/splash_screen.dart';
import 'package:innovate_2/screens/teacher_homepage.dart';
import 'package:innovate_2/screens/teacher_signup.dart';
import 'package:innovate_2/widgets/utils.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({super.key});

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    bool isLoading = false;
    Future<void> loginTeacher() async {
      setState(() {
        isLoading = true;
      });
      String res = await AuthMethods().loginTeacher(
          email: _emailController.text, password: _passwordController.text);
      setState(() {
        isLoading = false;
      });
      if (res != 'Success') {
        showSnackBar(context, res);
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const TeacherHomepage(),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Teacher Login',
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
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Teacher Email',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 45.0),
              ElevatedButton(
                onPressed: () async {
                  await loginTeacher();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(31, 68, 255, 0.776),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minimumSize: const Size(350.0, 45.0),
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:isLoading?const CircularProgressIndicator(): const Text(
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
                onPressed: () {},
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TeacherSignup()));
                      // Perform navigation logic here
                    },
                    child: const Text(
                      'Create an Account',
                      style: TextStyle(
                        color: Color.fromRGBO(31, 68, 255, 0.776),
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
