import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:http/http.dart' as http;

class Utils{
  static verify()async{
    final link1 = Uri.parse("https://jsonplaceholder.typicode.com/users");
    final data = await http.get(link1);
    try{
      if (data.statusCode==200) {
        return jsonDecode(data.body);
      }
    }
    catch(e){
      return e;
    }
  }
  static mycons()async{
    final link1 = Uri.parse("https://jsonplaceholder.typicode.com/users");
    final data = await http.get(link1);
    try{
      if (data.statusCode==200) {
        return jsonDecode(data.body);
      }
    }
    catch(e){
      return e;
    }
  }


}