import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileOperations{
  static dynamic decodedObject;
  static dynamic decodedNapData;

//Gets the file directory for the application.
  Future<String> get localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

//Returns the file used to save the settings object.
  Future<File> get localFile async{
    final path = await localPath;
    return File('$path/settings.txt');
  }

//Returns the file used to save the napData.
  Future<File> getDataFile(int number) async{
    final path = await localPath;
    return File("$path/nap$number.txt");
  }

//Writes the parsed String data into the settings file.
  Future<File> writeSettings(String data) async{
    final file = await localFile;
    print("Written $data to file!");
    return file.writeAsString('$data');
  }

//Reads the contents of the napdata file and loads the contents into a local static variable.
  readNapData(int napNumber) async{
    try{
      final file = await getDataFile(napNumber);
      String contents = await file.readAsString();

      Map<String, dynamic> decodedUserNaps = jsonDecode(contents);
      decodedNapData = decodedUserNaps;

      print("Read $decodedUserNaps from file!");
    }
    catch(e){
      e.toString();
    }
  }

//Writes the parsed String data into the napData file.
  Future<File> writeNapData(String data, int napNumber) async{
    final file = await getDataFile(napNumber);
    print("Written $data to $file!");
    return file.writeAsString('$data');
  }

//Reads the contents of the settings file and loads the contents into a local static variable.
  readSettings() async{
    try{
      final file = await localFile;
      String contents = await file.readAsString();
      
      Map<String, dynamic> decodedSettings = jsonDecode(contents);
      decodedObject = decodedSettings;

      print("Read $decodedObject from file!");
    }
    catch(e){
      return e.toString();
    }
  }

  deleteAllNapData() async{
    for(int i = 1; i < 500; i++){
      File file = await getDataFile(i);

      if(await file.exists()){
        file.delete(recursive: true);
      }

      decodedNapData = null;
    }
  }

//Deletes the settings file.
  deleteFile() async{
    final file = await localFile;
    file.delete(recursive: true);
    decodedObject = null;
  }
}