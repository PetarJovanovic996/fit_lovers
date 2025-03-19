import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fit_lovers/data/models/exercise.dart';

class ExerciseService {
  final String apiUrl = 'https://api.api-ninjas.com/v1/exercises';
  final String apiKey = 'Qu0a/qJJ1uBVlNpaPjB4Rw==E9r5HYyxW1uQcVSh';

  Future<List<Exercise>> fetchExercises({
    String? type,
    String? name,
  }) async {
    try {
      String url = apiUrl;
      Map<String, String> queryParams = {};

      if (type != null) {
        queryParams['type'] = type;
      }

      if (name != null) {
        queryParams['name'] = name;
      }

      if (queryParams.isNotEmpty) {
        url += '?${Uri(queryParameters: queryParams).query}';
      }
      // ...

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'X-Api-Key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((jsonItem) => Exercise.fromJson(jsonItem)).toList();
      } else {
        throw Exception(
            'Failed to load exercises. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Failed to load exercises: $e");
    }
  }

  Future<Exercise> getSingleExercise(String name) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl?name=$name'),
        headers: {
          'X-Api-Key': apiKey,
        },
      );
      if (response.statusCode != 200) {
        throw Exception(
            "Failed to load exercise. Status code: ${response.statusCode}");
      }
      final List<dynamic> data = json.decode(response.body);
      return Exercise.fromJson(data[0]);
    } catch (e) {
      throw Exception("Failed to load exercise: $e");
    }
  }
}
