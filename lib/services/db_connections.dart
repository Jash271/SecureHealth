import 'dart:convert';

import 'package:http/http.dart' as http;
class DBConnections{
  Future verifyUser(String data) async{
    var url = 'https://health-care-auto.herokuapp.com/api/user/findUser';
    var response = await http.post(url,body: jsonEncode(<String, String>{
      "contact" : data
    }), headers: {
      "Content-Type" : "application/json"
    });
    print(response.body);
    var output = jsonDecode(response.body);
    assert(output is List);
    var isFound = output[1];
    assert(isFound is Map);
    print(isFound);
  }
}