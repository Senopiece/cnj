import 'package:freezed_annotation/freezed_annotation.dart';

part 'chuck_norris_joke.freezed.dart';
part 'chuck_norris_joke.g.dart';

@freezed
class ChuckNorrisJoke with _$ChuckNorrisJoke {
  const factory ChuckNorrisJoke({
    required List<String> categories,
    @JsonKey(name: 'icon_url') required String iconUrl,
    required String id,
    required String url,
    required String value,
  }) = _ChuckNorrisJoke;

  factory ChuckNorrisJoke.fromJson(Map<String, Object?> json) =>
      _$ChuckNorrisJokeFromJson(json);
}
