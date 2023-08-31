import 'dart:convert';

import 'package:challenge/models/response_model.dart';
import 'package:challenge/config.dart';
import 'package:http/http.dart' as http;

class LocationController {
  static Future<ResponseModel?> getLocations({required String search}) async {
    final response = await http.get(
        Uri.https(baseURL, "mvv/XML_STOPFINDER_REQUEST", {
          'language': 'de',
          'outputFormat': 'RapidJSON',
          'type_sf': 'any',
          'name_sf': search
        }),
        headers: {
          'Accept-Charset': 'utf-8',
        }).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      ResponseModel responseModel = ResponseModel.fromJson(body);
      return responseModel;
    } else {
      logger.d(response.body);
      return null;
    }
  }
}
