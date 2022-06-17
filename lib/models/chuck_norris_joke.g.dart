// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chuck_norris_joke.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChuckNorrisJoke _$$_ChuckNorrisJokeFromJson(Map<String, dynamic> json) =>
    _$_ChuckNorrisJoke(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      iconUrl: json['icon_url'] as String,
      id: json['id'] as String,
      url: json['url'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$$_ChuckNorrisJokeToJson(_$_ChuckNorrisJoke instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'icon_url': instance.iconUrl,
      'id': instance.id,
      'url': instance.url,
      'value': instance.value,
    };
