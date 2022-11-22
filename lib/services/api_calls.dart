import 'dart:developer';

import 'package:http/http.dart' as http;
class ApiCalls{
  static const String _baseUrl = 'https://api.imgflip.com';

  static Future<http.Response> apiGetMemes() async {
    var url = Uri.parse('$_baseUrl/get_memes');
    var response = await http.get(url,);
    log("response $response");
    return response;
  }

}