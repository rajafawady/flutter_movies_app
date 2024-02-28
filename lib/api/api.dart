import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future discover() async {
  await dotenv.load();
  final String url =
      '${dotenv.env["API_URL"]}/discover/movie?api_key=${dotenv.env["API_KEY"]}';
  final response = await http.get(Uri.parse(url));
  var responseData = json.decode(response.body);
  return responseData['results'];
}
