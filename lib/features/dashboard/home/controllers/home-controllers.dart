import 'package:maple/services/local_storage_service.dart';

class HomeControllers {
  static Future<String> getUsername () async {
    Map<String, dynamic> data = await LocalStorageService.load('user');
    print('data ' + data.toString());
    return data['data']['username'];
  }
}