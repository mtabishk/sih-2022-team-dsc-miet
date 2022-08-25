import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kiran_user_app/models/nlp_service_model.dart';

class NLPService {
  String baseUrl = "http://13.235.195.145:5000";

  Future<NLPServiceModel> callNLPSentimentAnalysis(String message) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + '/comment'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId': message,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return NLPServiceModel.fromJson(responseData);
      } else {
        throw Exception("Failed to load");
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
