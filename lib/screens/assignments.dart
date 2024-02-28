import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:innovate_2/global/global_var.dart';

class Assignments extends StatefulWidget {
  const Assignments({Key? key}) : super(key: key);

  @override
  State<Assignments> createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  File? selectedPdf;
  String? responseData;

  @override
  Widget build(BuildContext context) {
    Future<void> uploadViaScript() async {
      try {
        var dio = Dio();
        // Set content-type explicitly for PDF uploads
        //dio.options.contentType = 'multipart/form-data';

        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );

        if (result != null) {
          File file = File(result.files.single.path ?? "");
          String fileName = file.path.split('/').last;

          FormData data = FormData.fromMap({
            'file': await MultipartFile.fromFile(file.path, filename: fileName),
          });
          //dio.options.contentType = 'application/pdf';
          var response = await dio.post("${GlobalVariables.Url}/analyze_pdf",
              data: data, onSendProgress: (int sent, int total) {
            // Use a logging framework for production
            debugPrint('$sent  $total');
          });

          setState(() {
            responseData = response.data.toString();
            selectedPdf = null;
          });
        } else {
          debugPrint("Response is null");
        }
      } catch (e) {
        // Handle errors appropriately
        debugPrint("Error: $e");
        // Provide user feedback or implement error recovery
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
          padding: const EdgeInsets.symmetric(vertical: 350.0, horizontal: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selectedPdf == null && responseData != null)
                Text(
                  responseData!,
                  style: const TextStyle(fontSize: 16),
                ),
              if (selectedPdf == null)
                ElevatedButton(
                  onPressed: uploadViaScript,
                  child: const Text('Upload the essay file'),
                )
              else
                IconButton(
                  icon: const Icon(
                    Icons.upload,
                    size: 40,
                  ),
                  onPressed: uploadViaScript,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
