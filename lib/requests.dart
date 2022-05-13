import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_trainer/training.dart';

final http.Client client = http.Client();
// better than http.get() if multiple requests to the same server

// If you connect the Android emulator to the webserver listening to localhost:8080
const String baseUrl = "http://10.0.2.2:8080";


// If instead you want to use a real phone, run this command in the linux terminal
//   ssh -R joans.serveousercontent.com:80:localhost:8080 serveo.net
//const String baseUrl = "https://joans.serveousercontent.com";

Future<TrainingList> getTrainings() async {
  String uri = "$baseUrl/get_trainings";
  final response = await client.get(uri);
  if (response.statusCode == 200) {
    // print("statusCode=$response.statusCode");
    // print(utf8.decode(response.bodyBytes)) as Map;
    // If the server did return a 200 OK response, then parse the JSON.
    Map<String, dynamic> decoded = convert.jsonDecode(utf8.decode(response.bodyBytes));
    return TrainingList(decoded);
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    // print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}

void generateTraining(int location, int type, int part) async {
  String uri = "$baseUrl/generate_training?$location?$type?$part";
  final response = await client.get(uri);
  if (response.statusCode == 200) {
    // print("statusCode=$response.statusCode");
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    // print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}

Future<ExerciseList> getExercises() async {
  String uri = "$baseUrl/get_exercises";
  final response = await client.get(uri);
  if (response.statusCode == 200) {
    // print("statusCode=$response.statusCode");
    // print(utf8.decode(response.bodyBytes)) as Map;
    // If the server did return a 200 OK response, then parse the JSON.
    Map<String, dynamic> decoded = convert.jsonDecode(utf8.decode(response.bodyBytes));
    return ExerciseList(decoded);
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    // print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}
