import 'dart:convert';

import 'package:http/http.dart' as http;

class Utils{
  static verify()async{
    final link1 = Uri.parse("");
    final data = await http.get(link1);
    if (data.statusCode==200) {
      return jsonDecode(data.body);
    }
  }
}