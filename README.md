# sync-folder-with-drive
A project I started to learn Dart. It's not completed, but it does currently detect if a file is added and adds it to the root Google Drive folder

To use, you'll have to generate a Client ID by going to the Google API Dashboard, creating a new project with the Drive API enabled. Make sure to specifically enable "See, edit, create, and delete all of your Google Drive files" in `Credentials > OAuth consent screen > Add scope`

Then you'll need to put your client ID and client secret into the two constants at the beginning of `./main.dart`

Since this would be an unverified Google App, you could only make the program authenticate you 100 times unfortunately. If you wanted to run it more than that, you would have to create a privacy policy, etc. and get them to verify you through the same Credentials page in the API Dashboard
