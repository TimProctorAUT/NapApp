import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileOperations{
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
//Returns a Map<String, dynamic>.
//Create local dynamic variable and assign it to "await readNapData(napNumber)"
//ensure that await is used to prevent trying to display null data.
  dynamic readNapData(int napNumber) async{
    try{
      final file = await getDataFile(napNumber);
      String contents = await file.readAsString();

      Map<String, dynamic> decodedUserNaps = jsonDecode(contents);
      //decodedNapData = decodedUserNaps;

      print("Read $decodedUserNaps from file!");

      return decodedUserNaps;
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
  dynamic readSettings() async{
    try{
      final file = await localFile;

      String contents = await file.readAsString();
      
      Map<String, dynamic> decodedSettings = jsonDecode(contents);
      //decodedObject = decodedSettings;

      print("Read $decodedSettings from file!");

      return decodedSettings;
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

      // decodedNapData = null;
    }
  }

//Deletes the settings file.
  deleteFile() async{
    final file = await localFile;
    file.delete(recursive: true);
    //decodedObject = null;
  }

  //Get Number of Valid Nap Files Saved
  Future<int> getVaildNaps() async{
    var lastNapNumber = 0;

    for(int i = 1; i < 500; i++){
      File file = await getDataFile(i);

      if(await file.exists()){
        print("YEET that Meat");
        lastNapNumber = i;
      }
      else
      {
        print("Nah Doesn't Exist");
        i = 500;
      }
    }
    return lastNapNumber;
  }
}