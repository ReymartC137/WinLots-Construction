import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


class AssistantMethod{
  uploadImage(String title, List<XFile>? images) async{

    var request = http.MultipartRequest("POST",Uri.parse("https://reqres.in/api/users"));

    request.fields['title'] = "dummyImage";


    var picture = http.MultipartFile.fromBytes('image', (await rootBundle.load('assets/testimage.png')).buffer.asUint8List(),
        filename: 'testimage.png');

    request.files.add(picture);

    var response = await request.send();

    var responseData = await response.stream.toBytes();

    var result = String.fromCharCodes(responseData);

    print('uwu'+result.toString());



  }
}