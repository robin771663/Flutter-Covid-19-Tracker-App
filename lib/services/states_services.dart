import 'dart:convert';

//import 'package:covid_tracker/model/country_model.dart';
import 'package:covid_tracker/model/world_states_model.dart';
import 'package:covid_tracker/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  
Future<WorldStatesModel> fetchWorldStatesRecordes()async{
  
  final response = await http.get(Uri.parse(AppUrl.baseUrl));
  if (response.statusCode==200) {
    var data= jsonDecode(response.body);
    return WorldStatesModel.fromJson(data);
  }else{
    throw Exception("error");
  }

}
  var data;
Future<List<dynamic>> countriesList()async{

  final response = await http.get(Uri.parse(AppUrl.countrisList));
  if (response.statusCode==200) {
    var data= jsonDecode(response.body);
    return data;
  }else{
    throw Exception("error");
  }

}

}