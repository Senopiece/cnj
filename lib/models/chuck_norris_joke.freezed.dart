// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chuck_norris_joke.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChuckNorrisJoke _$ChuckNorrisJokeFromJson(Map<String, dynamic> json) {
  return _ChuckNorrisJoke.fromJson(json);
}

/// @nodoc
mixin _$ChuckNorrisJoke {
  @JsonKey(name: 'icon_url')
  String get iconUrl => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChuckNorrisJokeCopyWith<ChuckNorrisJoke> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChuckNorrisJokeCopyWith<$Res> {
  factory $ChuckNorrisJokeCopyWith(
          ChuckNorrisJoke value, $Res Function(ChuckNorrisJoke) then) =
      _$ChuckNorrisJokeCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'icon_url') String iconUrl,
      String id,
      String url,
      String value});
}

/// @nodoc
class _$ChuckNorrisJokeCopyWithImpl<$Res>
    implements $ChuckNorrisJokeCopyWith<$Res> {
  _$ChuckNorrisJokeCopyWithImpl(this._value, this._then);

  final ChuckNorrisJoke _value;
  // ignore: unused_field
  final $Res Function(ChuckNorrisJoke) _then;

  @override
  $Res call({
    Object? iconUrl = freezed,
    Object? id = freezed,
    Object? url = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      iconUrl: iconUrl == freezed
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ChuckNorrisJokeCopyWith<$Res>
    implements $ChuckNorrisJokeCopyWith<$Res> {
  factory _$$_ChuckNorrisJokeCopyWith(
          _$_ChuckNorrisJoke value, $Res Function(_$_ChuckNorrisJoke) then) =
      __$$_ChuckNorrisJokeCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'icon_url') String iconUrl,
      String id,
      String url,
      String value});
}

/// @nodoc
class __$$_ChuckNorrisJokeCopyWithImpl<$Res>
    extends _$ChuckNorrisJokeCopyWithImpl<$Res>
    implements _$$_ChuckNorrisJokeCopyWith<$Res> {
  __$$_ChuckNorrisJokeCopyWithImpl(
      _$_ChuckNorrisJoke _value, $Res Function(_$_ChuckNorrisJoke) _then)
      : super(_value, (v) => _then(v as _$_ChuckNorrisJoke));

  @override
  _$_ChuckNorrisJoke get _value => super._value as _$_ChuckNorrisJoke;

  @override
  $Res call({
    Object? iconUrl = freezed,
    Object? id = freezed,
    Object? url = freezed,
    Object? value = freezed,
  }) {
    return _then(_$_ChuckNorrisJoke(
      iconUrl: iconUrl == freezed
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChuckNorrisJoke implements _ChuckNorrisJoke {
  const _$_ChuckNorrisJoke(
      {@JsonKey(name: 'icon_url') required this.iconUrl,
      required this.id,
      required this.url,
      required this.value});

  factory _$_ChuckNorrisJoke.fromJson(Map<String, dynamic> json) =>
      _$$_ChuckNorrisJokeFromJson(json);

  @override
  @JsonKey(name: 'icon_url')
  final String iconUrl;
  @override
  final String id;
  @override
  final String url;
  @override
  final String value;

  @override
  String toString() {
    return 'ChuckNorrisJoke(iconUrl: $iconUrl, id: $id, url: $url, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChuckNorrisJoke &&
            const DeepCollectionEquality().equals(other.iconUrl, iconUrl) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(iconUrl),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  _$$_ChuckNorrisJokeCopyWith<_$_ChuckNorrisJoke> get copyWith =>
      __$$_ChuckNorrisJokeCopyWithImpl<_$_ChuckNorrisJoke>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChuckNorrisJokeToJson(this);
  }
}

abstract class _ChuckNorrisJoke implements ChuckNorrisJoke {
  const factory _ChuckNorrisJoke(
      {@JsonKey(name: 'icon_url') required final String iconUrl,
      required final String id,
      required final String url,
      required final String value}) = _$_ChuckNorrisJoke;

  factory _ChuckNorrisJoke.fromJson(Map<String, dynamic> json) =
      _$_ChuckNorrisJoke.fromJson;

  @override
  @JsonKey(name: 'icon_url')
  String get iconUrl => throw _privateConstructorUsedError;
  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get url => throw _privateConstructorUsedError;
  @override
  String get value => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ChuckNorrisJokeCopyWith<_$_ChuckNorrisJoke> get copyWith =>
      throw _privateConstructorUsedError;
}
