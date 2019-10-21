import 'dart:convert';
import 'dart:io';
import 'package:first_app/setting.dart';
import 'package:first_app/userNapData.dart';
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
    }
  }

//Deletes the settings file.
  deleteFile() async{
    final file = await localFile;
    file.delete(recursive: true);
  }

  //Get Number of Valid Nap Files Saved
  Future<int> getVaildNaps() async{
    var lastNapNumber = 1;

    for(int i = 1; i < 500; i++){
      File file = await getDataFile(i);

      if(await file.exists()){
        lastNapNumber = i;
      }
      else
      {
        i = 500;
      }
    }
    return lastNapNumber;
  }

//TODO revise default settings for nap
  dynamic readObjectFromFile(String object, {int napNumber}) async{

    print("$object $napNumber");
    
    if(object.toUpperCase() == "napsettings".toUpperCase()){
      dynamic decodedObject = await readSettings();

      try{
        NapSettingsData settingsObject = NapSettingsData(
          vibrationInterval: decodedObject['vibrateInterval'],
          napLimit: decodedObject['napLimit'],
          napLength: decodedObject['napLength'],
          selectedVibrate: decodedObject['selectedVibrate'],
          wantsAudio: decodedObject['wantsAudio'],
          wantsAlarmAudio: decodedObject['wantsAlarmAudio'],
          wantsAlarmVibrate: decodedObject['wantsAlarmVibrate'],
          selectedAudioFile: decodedObject['selectedAudioFile'],
          selectedAlarmSound: decodedObject['selectedAlarmSound'],
          dontDisplayInstructions: decodedObject['dontDisplayInstructions'],
          hasSavedSettings: decodedObject['hasSavedSettings'],
          wantsGentleWake: decodedObject['gentleWake'],
          //TODO add colorblind from file
        );

        settingsObject.defaultSettings = false;

        return settingsObject;
      }
      //Default nap settings
      catch(e){
        NapSettingsData settingsObject = NapSettingsData(
          vibrationInterval: 2,
          napLength: 1,
          napLimit: 1,
          dontDisplayInstructions: false,
          wantsAudio: false,
          wantsGentleWake: true,
          defaultSettings: true
          //TODO add colorblind default.
        );

        return settingsObject;
      }
    }
    else if(object.toUpperCase() == "usernapdata".toUpperCase()){
      try{
        dynamic decodedNapData = await readNapData(napNumber);
        
        UserNapData napData = UserNapData(
          napNumber: decodedNapData['napNumber'],
          successfullSleep: decodedNapData['successfullSleep'],
          timeOfNap: decodedNapData['timeOfNap'],
          timeSleptInSeconds: decodedNapData['timeSleptInSeconds'],
          timeToSleep: decodedNapData['timeToSleep']
        );

        return napData;
      }
      catch(e){
        print("nap data file doesnt exist.");
      }
    }
    else{
      print("The string you entered into this function is incorrect. Please enter 'napsettings' or 'usernapdata' ");
    }
  }
}