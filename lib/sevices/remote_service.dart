import 'package:alma_gest/models/User.dart';
import 'package:http/http.dart' as http;

class remote_service {
  Future<List<User>?> getUsers() async {
    var httpClient = http.Client();
    var uri = Uri.parse('');
    var response = await httpClient.get(uri);

    if(response.statusCode == 200) {
      var json = response.body;
      return userFromJson(json);
    }
  }

  
}
