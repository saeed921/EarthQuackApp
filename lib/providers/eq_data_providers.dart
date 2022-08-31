import 'dart:convert';

import 'package:earthquack_apps_by_rest_api/models/data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class EqDataProvider extends ChangeNotifier{
  EarthQuackModel? earthQuackModel;
  String startTime= "2022-08-20";
  String endTime="2022-08-30";
  String minValue="5.0";

  void setNewDate(String startTime, String endTime, String minValue){
    startTime=this.startTime;
    endTime=this.endTime;
    minValue=this.minValue;
  }
  void getCurrentDate()async{
    final uri=Uri.parse(
        "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=$startTime&endtime=$endTime&minmagnitude=$minValue");
    try{
      final response= await get(uri);
      final map=json.decode(response.body);
      if(response.statusCode==200){
        earthQuackModel= EarthQuackModel.fromJson(map);
        print(earthQuackModel!.features!.length );
        notifyListeners();
    }
      else{
        print(map["message"]);
    }
    }catch (error){
      rethrow;
    }



  }
}