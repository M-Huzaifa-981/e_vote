
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:e_vote/database/users_db.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget {
  const Test({super.key});
  @override
  TestState createState() => TestState();
}

class TestState extends State<Test> {
  File? _image;
  final picker = ImagePicker();
  String resultText = '';
  bool loading = false;
   String nodeServerUrl = "https://b517a7664e60.ngrok-free.app"; // Change if deployed 172.18.208.1 , 192.168.18.16

  TextEditingController urlCotroller = TextEditingController();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Future<void> registerUser(String userId) async {
  //   if (_image == null) return;
  //   setState(() {
  //     loading = true;
  //   });
  //   final url = "${nodeServerUrl}/register";
  //   log("reg url : ${url}");
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.fields['user_id'] = userId;
  //   request.files.add(await http.MultipartFile.fromPath(
  //     'file',
  //     _image!.path,
  //     contentType: http.MediaType('image', 'png'),
  //   ));
  //
  //   var response = await request.send();
  //   var respStr = await response.stream.bytesToString();
  //   log("Reg response: ${respStr}");
  //   setState(() {
  //     loading = false;
  //     resultText = respStr;
  //   });
  // }
  //
  // Future<void> verifyUser() async {
  //   if (_image == null) return;
  //   setState(() {
  //     loading = true;
  //   });
  //   final url = "${nodeServerUrl}/verify";
  //   log("verify url : ${url}");
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.files.add(await http.MultipartFile.fromPath(
  //     'file',
  //     _image!.path,
  //     contentType: http.MediaType('image', 'png'),
  //   ));
  //
  //   var response = await request.send();
  //   var respStr = await response.stream.bytesToString();
  //   log("Verify response: ${respStr}");
  //   setState(() {
  //     loading = false;
  //     resultText = respStr;
  //   });
  // }

  Future<void> registerUser(String userId) async {
    if (_image == null) return;
    // if(urlCotroller.text.isEmpty) return;
      nodeServerUrl = urlCotroller.text = "https://5291f6ee05fa.ngrok-free.app";
    setState(() => loading = true);

    try {
      final url = "$nodeServerUrl/register";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['user_id'] = userId;
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        _image!.path,
        contentType: http.MediaType('image', 'png'),
      ));

      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      log("Register Response: $respStr");

      // parse JSON
      var data = jsonDecode(respStr);
      setState(() {
        resultText = "Status: ${data['status']}\n"
            "Reason: ${data['reason'] ?? 'ok'}\n"
            "UserID: ${data['user_id'] ?? '-'}\n"
            "Samples: ${data['samples'] ?? '-'}";
      });
    } catch (e) {
      log("Register Error: $e");
      setState(() => resultText = "Error: $e");
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> verifyUser() async {
    if (_image == null) return;
    // if(urlCotroller.text.isEmpty) return;
      nodeServerUrl = urlCotroller.text = "https://5291f6ee05fa.ngrok-free.app";
    setState(() => loading = true);

    try {
      final url = "$nodeServerUrl/verify";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        _image!.path,
        contentType: http.MediaType('image', 'png'),
      ));

      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      log("Verify Response: $respStr");

      // parse JSON
      var data = jsonDecode(respStr);
      setState(() {
        if (data['matched'] == true) {
          resultText = "✅ Matched!\nUser: ${data['user_id']}\nDistance: ${data['distance']}";
        } else {
          resultText = "❌ Not Matched\nReason: ${data['reason']}";
        }
      });
    } catch (e) {
      log("Verify Error: $e");
      setState(() => resultText = "Error: $e");
    } finally {
      setState(() => loading = false);
    }
  }



  Future<void> addUser(String userId, String name, String cnic) async {
    final url = Uri.parse('http://192.168.18.16:3000/addUser'); // NodeJS server IP
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'name': name,
        'cnic': cnic,
      }),
    );

    print('Response: ${response.body}');
  }


  Future<void> getUser(String userId) async {
    final url = Uri.parse('http://192.168.18.16:3000/getUser/$userId');
    final response = await http.get(url);
    print('User data: ${response.body}');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Recognition')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(

            children: [
              _image == null
                  ?
              Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(opacity: 0.2,child: Icon(Icons.image_not_supported, size: 200)),
                      Text('No image selected', style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  )
                  :
              Image.file(_image!, height: 200),

              SizedBox(height: 11),

              loading ?  Center(
                child: CircularProgressIndicator(),)
                  :
             Column(
                children: [
                  ElevatedButton(onPressed: pickImage, child: Text('Capture Image')),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: urlCotroller,
                    decoration: InputDecoration(
                      label: Text("Enter Url"),
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 11),
                  TextFormField(
                    // controller: urlCotroller,
                    decoration: InputDecoration(
                        label: Text('User ID'),
                        border: OutlineInputBorder()
                    ),
                  ),

                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () => registerUser('user1'), // replace with dynamic user input
                    child: Text('Register User'),
                  ),

                  SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: verifyUser,
                    child: Text('Verify User'),
                  ),
                  SizedBox(height: 10),

                 if(resultText.isNotEmpty) Container(
                   padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all()
                      ),
                      child: Text(
                        "${resultText}",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
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
