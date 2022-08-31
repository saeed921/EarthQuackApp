import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/data_model.dart';

class EarthquakeProvider extends ChangeNotifier{
  EarthquakeModel? earthquakeModel;
  String startTime="2022-08-20";
  String endTime="2022-08-30";
  String minvalue="5.0";

  void setNewDate(String sT, String eT,String mV) {

    startTime=sT;
    endTime=eT;
    minvalue=mV;
    notifyListeners();
  }
  void getCurrentData() async {
    final uri = Uri.parse(
        "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=$startTime&endtime=$endTime&minmagnitude=$minvalue");

    try {
      final response = await get(uri);
      final map = json.decode(response.body);
      if (response.statusCode == 200) {
        earthquakeModel = EarthquakeModel.fromJson(map);
        print(earthquakeModel!.features!.length);
        notifyListeners();
      } else {
        print(map["message"]);
      }
    } catch (error) {
      rethrow;
    }
  }



}