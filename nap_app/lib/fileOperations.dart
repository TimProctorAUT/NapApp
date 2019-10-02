import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileOperations{
  static dynamic decodedObject;

//FILE OPERATIONS
//----------------------------------------------------------------
  Future<String> get localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localFile async{
    final path = await localPath;
    return File('$path/settings.txt');
  }

  Future<File> writeSettings(String data) async{
    final file = await localFile;
    print("Written $data to file!");
    return file.writeAsString('$data');
  }

  Future<String> readSettings() async{
    try{
      final file = await localFile;
      String contents = await file.readAsString();
      
      Map<String, dynamic> decodedSettings = jsonDecode(contents);
      decodedObject = decodedSettings;

      print("Read $decodedObject from file!");
      
      return decodedObject;
    }
    catch(e){
      return e.toString();
    }
  }

  deleteFile() async{
    final file = await localFile;
    file.delete(recursive: true);
    decodedObject = null;
  }
}