import 'package:equatable/equatable.dart';
import '/models/character.dart';

class Location extends Equatable {
  final int id;
  final String name;
  final String? type;
  final String? dimension;
  final List<Character>? residents;

  const Location({
    required this.id,
    required this.name,
    this.type,
    this.dimension,
    this.residents,
});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] ?? (json['url'] as String?)?.lastIndexOf('/') ?? -1,
      name: json['name'],
      type: json['type'],
      dimension: json['dimension'],
      residents: json['residents'].map<Character>((json) => Character.fromJson(json)).toList(),
    );
  }

  @override
  List<Object?> get props => [id];
}
