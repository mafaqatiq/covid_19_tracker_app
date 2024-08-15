import 'dart:convert';

import 'package:covid_19_tracker_app/Model/WorldStatesModel.dart';
import 'package:covid_19_tracker_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices{

  // api containing object with its data
  Future<WorldStatesModel> getWorldStatesApi()async{
    final response =await http.get(Uri.parse(AppUrl.worldStatsApi));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200)
    {
      return WorldStatesModel.fromJson(data);
    }
    else
    {
      throw Exception('Error');
    }
  }

  // api of a List having nested objects
  Future<List<dynamic>> getCountriesListApi()async{
    final response =await http.get(Uri.parse(AppUrl.countriesListApi));
    var data;
    if(response.statusCode == 200)
    {
      data  = jsonDecode(response.body.toString());
      return data;
    }
    else
    {
      throw Exception('Error');
    }
  }


}