import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http_parser/http_parser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpeakSee',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 3, 31, 106),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 3, 31, 106),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 0, 173, 181),
          ),
        ),
      ),
      home: const PermissionPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PermissionPage extends StatefulWidget {
  const PermissionPage({Key? key}) : super(key: key);

  @override
  _PermissionPageState createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  List<XFile> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SpeakSee',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
        child: selectedImages.isNotEmpty
            ? GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: selectedImages.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  child: Image.file(
                    File(selectedImages[index].path),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedImages.removeAt(index);
                      });
                    },
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        )
            : ElevatedButton(
          onPressed: () async {
            _pickAndSaveImage();
          },
          child: const Text('Pick and Save Images'),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showDialog(String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Received Text"),
          content: Text(text),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void doUpload(XFile image) async {
    setState(() {
      selectedImages = [image];
    });

    var request = await http.MultipartRequest(
      'POST',
      Uri.parse("http://10.0.2.2:5000/"),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image.path,
        filename: "image.jpg", // Set a unique filename for the image
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    var response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseData);
      print(decodedResponse);
      _showDialog("""
Sign :- """ + decodedResponse[
      'Sign'] + "   Hand :- " + decodedResponse[
      'Hand']); // Assuming the response contains a key named 'text'
    } else {
      print('Failed to upload image');
    }
  }

  Future<void> saveImages(
      List<List<int>> listOfListOfImages, List<XFile> images) async {
    // Get the application directory
    Directory? appDir = await getExternalStorageDirectory();

    // Iterate through each sublist of images
    for (int i = 0; i < listOfListOfImages.length; i++) {
      List<int> currentImages = listOfListOfImages[i];

      // Create a directory for each sublist
      DateTime now = new DateTime.now();

      String currentTime = now.day.toString() +
          ":" +
          now.month.toString() +
          ":" +
          now.year.toString() +
          ":" +
          now.hour.toString() +
          ":" +
          now.minute.toString() +
          ":" +
          now.second.toString();
      print(currentTime);
      print(appDir?.path);
      Directory directory =
      Directory('${appDir?.path}/${currentTime}Directory_$i');
      directory.createSync(recursive: true);

      // Save each image into the directory
      for (int j = 0; j < currentImages.length; j++) {
        XFile image = images[currentImages[j]];
        File newFile = File('${directory.path}/image_$j.jpg');
        await newFile.writeAsBytes(await image.readAsBytes());
      }
    }
  }

  Future<void> _pickAndSaveImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Clear previously selected images if any
      setState(() {
        selectedImages.clear();
      });
      doUpload(image);
    } else {
      print('No image selected.');
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
    if (build.version.sdkInt >= 30) {
      var re = await Permission.manageExternalStorage.request();
      return re.isGranted;
    } else {
      if (await permission.isGranted) {
        return true;
      } else {
        var result = await permission.request();
        return result.isGranted;
      }
    }
  }
}