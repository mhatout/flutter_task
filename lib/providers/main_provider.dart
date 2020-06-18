import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/main_model.dart';

import '../util/remote_uris.dart';
import 'package:http/http.dart' as http;

class MainProvider extends ChangeNotifier{

  MainModel mainModel = MainModel();

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  
  Future<void> fetchMainModel() async {
    _isLoading = true;
    notifyListeners();
    var response = await http.get(
      RemoteURIs.config["BASE_URL"],
    ).catchError(
      (error) {
        debugPrint('error: $error');
        return false;
      },
    );

    this.mainModel = await compute(parseReport, response.body);

    _isLoading = false;
    notifyListeners();
  }
}

MainModel parseReport(String responseBody) {
  final Map modelMap = json.decode(responseBody);
  MainModel parsedModel = MainModel.fromMap(modelMap);
  if (parsedModel == null) {
    throw new Exception("An error occurred : [ Status Code = ]");
  }
  return parsedModel;
}