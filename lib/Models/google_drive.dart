import 'dart:io';

import 'package:flutterapp/Models/secure_storage.dart';
import 'package:googleapis/drive/v3.dart' as Google;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

const _cliendId =
    '682964718808-rfbkjb5r5tk8gip24fnh50pqqdd65fs3.apps.googleusercontent.com';
const _cliendSecret = 'Rzjn2oZOu2T10hH70paiYjfg';

const _scopes = [Google.DriveApi.DriveFileScope];

mixin GoogleDrive {
  SecureStorage secureStorage = SecureStorage();

  Future<Google.File> uploadFile(File file) async {
    var client = await getHttpClient();
    var drive = Google.DriveApi(client);
    Google.File authedFile = Google.File();
    authedFile..name = DateTime.now().toString();
    authedFile..shared = true;
    Google.File response = await drive.files.create(authedFile,
        uploadMedia: Google.Media(file.openRead(), file.lengthSync()));
    print('fuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuck');
    print(response.webContentLink);
    print(response.webViewLink);
    print(response.exportLinks);
    print('fuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuck');
    return response;
  }

  Future<http.Client> getHttpClient() async {
    // var credential = await secureStorage.getCredentials();
    var credential;
    if (credential == null) {
      AutoRefreshingAuthClient authClient = await clientViaUserConsent(
          ClientId(_cliendId, _cliendSecret), _scopes, (url) => launch(url));
      secureStorage.saveCredentials(authClient.credentials.accessToken,
          authClient.credentials.refreshToken);
      return authClient;
    } else {
      return authenticatedClient(
          http.Client(),
          AccessCredentials(
              AccessToken(credential['type'], credential['data'],
                  DateTime.parse(credential['expiry'])),
              credential['refreshToken'],
              _scopes));
    }
  }
}
