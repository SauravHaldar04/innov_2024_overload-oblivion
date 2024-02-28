import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:innovate_2/global/global_var.dart';
import 'package:innovate_2/widgets/blue_button.dart';

class Assignments extends StatefulWidget {
  const Assignments({super.key});

  @override
  State<Assignments> createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  File? selectedPdf;
  @override
  Widget build(BuildContext context) {
    // Future<void> pickPdf() async {
    //   FilePickerResult? result = await FilePicker.platform.pickFiles(
    //     type: FileType.custom,
    //     allowedExtensions: ['pdf'],
    //   );

    //   if (result != null) {
    //     setState(() {
    //       selectedPdf = File(result.files.single.path!);
    //     });
    //   }
    // }
    Future uploadViaScript() async {
      var dio = Dio();
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path ?? " ");
        String fileName = file.path.split('/').last;
        String filePath = file.path;
        FormData data = FormData.fromMap({
          'pdf_path': await MultipartFile.fromFile(filePath, filename: fileName)
        });
        try {
          var response = await dio.post("${GlobalVariables.Url}/analyze_pdf",
              data: data, onSendProgress: (int sent, int total) {
            print('$sent  $total');
          });
          print(jsonDecode(response.data));
        } catch (e) {
          print(e.toString());
        }
      } else {
        print("Response is null");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Assignments',
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.primaryGradient),
        ),
      ),
      body: Center(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 350.0, horizontal: 60),
            child: IconButton(
              icon: selectedPdf == null
                  ? Icon(
                      Icons.upload,
                      size: 40,
                    )
                  : ElevatedButton(
                      onPressed: () {}, child: Text('Upload the essay file')),
              onPressed: uploadViaScript,
            )),
      ),
    );
  }
}
