import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/character_entity.dart';

part 'character_model.g.dart';

@HiveType(typeId: 0)
class CharacterModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final String species;

  @HiveField(4)
  final String gender;

  @HiveField(5)
  final String origin;

  @HiveField(6)
  final String location;

  @HiveField(7)
  final String image;

  @HiveField(8)
  final List<String> episode;

  @HiveField(9)
  final String url;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      origin: json['origin']['name'],
      location: json['location']['name'],
      image: json['image'],
      episode: List<String>.from(json['episode']),
      url: json['url'],
    );
  }

  CharacterEntity toEntity() {
    return CharacterEntity(
      id: id,
      name: name,
      status: status,
      species: species,
      gender: gender,
      origin: origin,
      location: location,
      image: image,
      episode: episode,
      url: url,
    );
  }

  factory CharacterModel.fromEntity(CharacterEntity entity) {
    return CharacterModel(
      id: entity.id,
      name: entity.name,
      status: entity.status,
      species: entity.species,
      gender: entity.gender,
      origin: entity.origin,
      location: entity.location,
      image: entity.image,
      episode: entity.episode,
      url: entity.url,
    );
  }
}
