// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'remote_config_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RemoteConfigResponse {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RemoteConfigs remoteConfigs) success,
    required TResult Function(RemoteConfigResponseError error, String? message)
        failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(RemoteConfigs remoteConfigs)? success,
    TResult Function(RemoteConfigResponseError error, String? message)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RemoteConfigs remoteConfigs)? success,
    TResult Function(RemoteConfigResponseError error, String? message)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RemoteConfigResponseSuccess value) success,
    required TResult Function(RemoteConfigResponseFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RemoteConfigResponseSuccess value)? success,
    TResult Function(RemoteConfigResponseFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RemoteConfigResponseSuccess value)? success,
    TResult Function(RemoteConfigResponseFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoteConfigResponseCopyWith<$Res> {
  factory $RemoteConfigResponseCopyWith(RemoteConfigResponse value,
          $Res Function(RemoteConfigResponse) then) =
      _$RemoteConfigResponseCopyWithImpl<$Res>;
}

/// @nodoc
class _$RemoteConfigResponseCopyWithImpl<$Res>
    implements $RemoteConfigResponseCopyWith<$Res> {
  _$RemoteConfigResponseCopyWithImpl(this._value, this._then);

  final RemoteConfigResponse _value;
  // ignore: unused_field
  final $Res Function(RemoteConfigResponse) _then;
}

/// @nodoc
abstract class _$$RemoteConfigResponseSuccessCopyWith<$Res> {
  factory _$$RemoteConfigResponseSuccessCopyWith(
          _$RemoteConfigResponseSuccess value,
          $Res Function(_$RemoteConfigResponseSuccess) then) =
      __$$RemoteConfigResponseSuccessCopyWithImpl<$Res>;
  $Res call({RemoteConfigs remoteConfigs});
}

/// @nodoc
class __$$RemoteConfigResponseSuccessCopyWithImpl<$Res>
    extends _$RemoteConfigResponseCopyWithImpl<$Res>
    implements _$$RemoteConfigResponseSuccessCopyWith<$Res> {
  __$$RemoteConfigResponseSuccessCopyWithImpl(
      _$RemoteConfigResponseSuccess _value,
      $Res Function(_$RemoteConfigResponseSuccess) _then)
      : super(_value, (v) => _then(v as _$RemoteConfigResponseSuccess));

  @override
  _$RemoteConfigResponseSuccess get _value =>
      super._value as _$RemoteConfigResponseSuccess;

  @override
  $Res call({
    Object? remoteConfigs = freezed,
  }) {
    return _then(_$RemoteConfigResponseSuccess(
      remoteConfigs == freezed
          ? _value.remoteConfigs
          : remoteConfigs // ignore: cast_nullable_to_non_nullable
              as RemoteConfigs,
    ));
  }
}

/// @nodoc

class _$RemoteConfigResponseSuccess implements RemoteConfigResponseSuccess {
  const _$RemoteConfigResponseSuccess(this.remoteConfigs);

  @override
  final RemoteConfigs remoteConfigs;

  @override
  String toString() {
    return 'RemoteConfigResponse.success(remoteConfigs: $remoteConfigs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoteConfigResponseSuccess &&
            const DeepCollectionEquality()
                .equals(other.remoteConfigs, remoteConfigs));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(remoteConfigs));

  @JsonKey(ignore: true)
  @override
  _$$RemoteConfigResponseSuccessCopyWith<_$RemoteConfigResponseSuccess>
      get copyWith => __$$RemoteConfigResponseSuccessCopyWithImpl<
          _$RemoteConfigResponseSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RemoteConfigs remoteConfigs) success,
    required TResult Function(RemoteConfigResponseError error, String? message)
        failure,
  }) {
    return success(remoteConfigs);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(RemoteConfigs remoteConfigs)? success,
    TResult Function(RemoteConfigResponseError error, String? message)? failure,
  }) {
    return success?.call(remoteConfigs);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RemoteConfigs remoteConfigs)? success,
    TResult Function(RemoteConfigResponseError error, String? message)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(remoteConfigs);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RemoteConfigResponseSuccess value) success,
    required TResult Function(RemoteConfigResponseFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RemoteConfigResponseSuccess value)? success,
    TResult Function(RemoteConfigResponseFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RemoteConfigResponseSuccess value)? success,
    TResult Function(RemoteConfigResponseFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class RemoteConfigResponseSuccess implements RemoteConfigResponse {
  const factory RemoteConfigResponseSuccess(final RemoteConfigs remoteConfigs) =
      _$RemoteConfigResponseSuccess;

  RemoteConfigs get remoteConfigs => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$RemoteConfigResponseSuccessCopyWith<_$RemoteConfigResponseSuccess>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoteConfigResponseFailureCopyWith<$Res> {
  factory _$$RemoteConfigResponseFailureCopyWith(
          _$RemoteConfigResponseFailure value,
          $Res Function(_$RemoteConfigResponseFailure) then) =
      __$$RemoteConfigResponseFailureCopyWithImpl<$Res>;
  $Res call({RemoteConfigResponseError error, String? message});
}

/// @nodoc
class __$$RemoteConfigResponseFailureCopyWithImpl<$Res>
    extends _$RemoteConfigResponseCopyWithImpl<$Res>
    implements _$$RemoteConfigResponseFailureCopyWith<$Res> {
  __$$RemoteConfigResponseFailureCopyWithImpl(
      _$RemoteConfigResponseFailure _value,
      $Res Function(_$RemoteConfigResponseFailure) _then)
      : super(_value, (v) => _then(v as _$RemoteConfigResponseFailure));

  @override
  _$RemoteConfigResponseFailure get _value =>
      super._value as _$RemoteConfigResponseFailure;

  @override
  $Res call({
    Object? error = freezed,
    Object? message = freezed,
  }) {
    return _then(_$RemoteConfigResponseFailure(
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as RemoteConfigResponseError,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RemoteConfigResponseFailure implements RemoteConfigResponseFailure {
  const _$RemoteConfigResponseFailure({required this.error, this.message});

  @override
  final RemoteConfigResponseError error;
  @override
  final String? message;

  @override
  String toString() {
    return 'RemoteConfigResponse.failure(error: $error, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoteConfigResponseFailure &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$RemoteConfigResponseFailureCopyWith<_$RemoteConfigResponseFailure>
      get copyWith => __$$RemoteConfigResponseFailureCopyWithImpl<
          _$RemoteConfigResponseFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RemoteConfigs remoteConfigs) success,
    required TResult Function(RemoteConfigResponseError error, String? message)
        failure,
  }) {
    return failure(error, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(RemoteConfigs remoteConfigs)? success,
    TResult Function(RemoteConfigResponseError error, String? message)? failure,
  }) {
    return failure?.call(error, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RemoteConfigs remoteConfigs)? success,
    TResult Function(RemoteConfigResponseError error, String? message)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RemoteConfigResponseSuccess value) success,
    required TResult Function(RemoteConfigResponseFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RemoteConfigResponseSuccess value)? success,
    TResult Function(RemoteConfigResponseFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RemoteConfigResponseSuccess value)? success,
    TResult Function(RemoteConfigResponseFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class RemoteConfigResponseFailure implements RemoteConfigResponse {
  const factory RemoteConfigResponseFailure(
      {required final RemoteConfigResponseError error,
      final String? message}) = _$RemoteConfigResponseFailure;

  RemoteConfigResponseError get error => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$RemoteConfigResponseFailureCopyWith<_$RemoteConfigResponseFailure>
      get copyWith => throw _privateConstructorUsedError;
}
