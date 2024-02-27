import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:innovate_2/global/global_var.dart';
import 'package:innovate_2/resources/auth_methods.dart';
import 'package:innovate_2/screens/teacher_login.dart';
import 'package:innovate_2/widgets/utils.dart';

class TeacherSignup extends StatefulWidget {
  const TeacherSignup({super.key});

  @override
  State<TeacherSignup> createState() => _TeacherSignupState();
}

class _TeacherSignupState extends State<TeacherSignup> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cpassController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  bool isLoading = false;
  Future<void> signUpTeacher() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().signUpTeacher(
        email: _emailController.text,
        password: _passwordController.text,
        teachername: _nameController.text,
        course: selectedValue,
        designation: _designationController.text);
    setState(() {
      isLoading = false;
    });
    if (res != 'Success') {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const TeacherLogin(),
        ),
      );
    }
  }

  String selectedValue = "Economics";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Teacher SignUp ',
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 120.0),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    floatingLabelStyle:
                        TextStyle(color: Color.fromRGBO(31, 68, 255, 0.776)),
                    focusColor: Color.fromRGBO(31, 68, 255, 0.776),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(31, 68, 255, 0.776)),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(31, 68, 255, 0.776)),
                    ),
                    labelText: 'Teacher Email',
                    floatingLabelStyle:
                        TextStyle(color: Color.fromRGBO(31, 68, 255, 0.776)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(31, 68, 255, 0.776)),
                    ),
                    labelText: 'Password',
                    floatingLabelStyle:
                        TextStyle(color: Color.fromRGBO(31, 68, 255, 0.776)),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _cpassController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(31, 68, 255, 0.776)),
                    ),
                    labelText: 'Confirm Password',
                    floatingLabelStyle:
                        TextStyle(color: Color.fromRGBO(31, 68, 255, 0.776)),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _designationController,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(31, 68, 255, 0.776)),
                    ),
                    labelText: 'Designation',
                    floatingLabelStyle:
                        TextStyle(color: Color.fromRGBO(31, 68, 255, 0.776)),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text("Select Course"),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  height: 70,
                  child: DropdownButton<String>(
                    elevation: 6,
                    value: selectedValue,
                    items: const <DropdownMenuItem<String>>[
                      DropdownMenuItem(
                        value: "Economics",
                        child: Text("Economics"),
                      ),
                      DropdownMenuItem(
                        value: "History",
                        child: Text("History"),
                      ),
                      DropdownMenuItem(
                        value: "Computer Science",
                        child: Text("Computer Science"),
                      ),
                      DropdownMenuItem(
                        value: "Political Science",
                        child: Text("Political Science"),
                      ),
                      DropdownMenuItem(
                        value: "Literature",
                        child: Text("Literature"),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                        // Perform actions based on the selected value
                      });
                    },
                  ),
                ),
                const SizedBox(height: 45.0),
                ElevatedButton(
                  onPressed: () async {
                    await signUpTeacher();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(31, 68, 255, 0.776),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    minimumSize: const Size(350.0, 45.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                  ),
                ),
                const SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already Have an account? ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (_) => const TeacherSignupPage()
                        // ));
                      },
                      child: const Text(
                        'Login',
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
      ),
    );
  }
}
