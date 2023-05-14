import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ricksy_flutter/api/data_state.dart';
import 'package:ricksy_flutter/models/character.dart';
import 'package:ricksy_flutter/models/episode.dart';

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
        final List<Character> characters =
            data.map(Character.fromJson).toList();

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

  Future<DataState<List<Episode>>> getEpisodes(Character character) async {
    final List<int> episodeIds = character.episodes.map((e) {
      final uri = Uri.parse(e);
      final segments = uri.pathSegments;
      final int id = int.parse(segments[segments.length - 1]);
      return id;
    }).toList();

    try {
      final response = await http.get(
        Uri.parse('$_baseURL/episode/${episodeIds.join(',')}'),
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
        if (character.episodes.length == 1) {
          final Map data = jsonDecode(response.body);
          final List<Episode> episodes = [Episode.fromJson(data)];

          return DataState(
            loading: false,
            data: episodes,
          );
        }
        final List data = jsonDecode(response.body);
        final List<Episode> episodes = data.map(Episode.fromJson).toList();

        return DataState(
          loading: false,
          data: episodes,
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
