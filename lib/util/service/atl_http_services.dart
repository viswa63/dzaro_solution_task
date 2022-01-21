// import '/util/service/cloud_response.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ATLHttpService {
//   static const String url = "http://127.0.0.1:3000/getNetWorkConnections";

//   static Future<ATLCloudResponse?> postCallWithOutAuth() async {
//     final response = await http.get(Uri.parse(url));
//     //  String url = "https://jsonplaceholder.typicode.com/posts";
//     // final response = await http.get(url);
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       return ATLCloudResponse.fromJson(jsonDecode(response.body));
//     } else {
//       return null;
//     }
//   }
// }
