import 'package:equatable/equatable.dart';

class Episode extends Equatable {

  final int id;
  final String name;
  final String airDate;
  final String episode;

  const Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
  });

  factory Episode.fromJson(dynamic json) {
    return Episode(
      id: json['id'],
      name: json['name'],
      airDate: json['air_date'],
      episode: json['episode'],
    );
  }

  @override
  List<Object?> get props => [id];
}