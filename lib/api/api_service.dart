import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ricksy_flutter/api/data_state.dart';
import 'package:ricksy_flutter/models/character.dart';

class ApiService {
  final _baseURL = 'https://rickandmortyapi.com/api';

  Future<DataState<List<Character>>> getCharacters() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseURL/character'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode != 200) {
        return DataState(
          loading: false,
          error: response.reasonPhrase,
        );
      } else {
        final List data = jsonDecode(response.body)['results'];
        final List<Character> characters = data.map(Character.fromJson).toList();

        return DataState(
          loading: false,
          data: characters,
        );
      }
    } catch (e) {
      log(e.toString());
      return DataState(
        loading: false,
        error: e.toString(),
      );
    }
  }
}
