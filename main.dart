import 'dart:io';

import 'package:googleapis/drive/v3.dart' as drive;
import 'package:watcher/watcher.dart';
import 'package:googleapis_auth/auth_io.dart';

// remove this for github push
const CLIENT_ID = "XXXXXXXXX.apps.googleusercontent.com"; // X's not representative of length of your client id
const CLIENT_SECRET = "XXXXXXXXXXXXX"; // X's not representative of length of your client secret

var id = new ClientId(CLIENT_ID, CLIENT_SECRET);

var scopes = ["https://www.googleapis.com/auth/drive"];

void prompt(String url) {
  print("Please go to the following URL and grant access:");
  print("  => $url");
  print("");
}

// Authenticated and auto refreshing client is available in [client].
void monitorThisFolder(AutoRefreshingAuthClient client) async {
  var watcher = DirectoryWatcher('./', pollingDelay: Duration(minutes: 1));

  await for (var event in watcher.events) {

    String fileName = event.path;

    if (event.type == ChangeType.ADD) {
      print("$fileName has been added");
    
      var driveAPI = new drive.DriveApi(client);
      
      var localFile = new File(fileName);
      var media = drive.Media(localFile.openRead(), localFile.lengthSync());
      var driveFile = new drive.File()
        ..name = fileName;
      driveAPI.files.create(driveFile, uploadMedia: media);

      client.close();

      // addToDrive();
    } else if (event.type == ChangeType.REMOVE) {
      print("$fileName has been removed");

      // don't have time to do this now, but if I come back to this in the future,
      // I will use the same api to get the ID of the file I created and delete it.
      // I would also finish the function below
      // Refer to here if you want to add stuff: https://pub.dartlang.org/documentation/googleapis/latest/googleapis.drive.v3/FilesResourceApi-class.html

      // removeFromDrive();
    } else if (event.type == ChangeType.MODIFY) {
      print("$fileName has been changed");

      // sendModificationsToDrive();
    }

  }
}

void main() async {
  
  var authenticatedClient = await clientViaUserConsent(id, scopes, prompt);

  await monitorThisFolder(authenticatedClient);
}