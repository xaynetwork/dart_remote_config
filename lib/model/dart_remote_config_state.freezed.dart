// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'dart_remote_config_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DartRemoteConfigState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RemoteConfig config, ExperimentationEngineResult experiments)
        success,
    required TResult Function(DartRemoteConfigStatus status,
            RemoteConfigResponseFailure? fetcherError)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            RemoteConfig config, ExperimentationEngineResult experiments)?
        success,
    TResult Function(DartRemoteConfigStatus status,
            RemoteConfigResponseFailure? fetcherError)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RemoteConfig config, ExperimentationEngineResult experiments)?
        success,
    TResult Function(DartRemoteConfigStatus status,
            RemoteConfigResponseFailure? fetcherError)?
        failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DartRemoteConfigStateSuccess value) success,
    required TResult Function(DartRemoteConfigStateFailure value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(DartRemoteConfigStateSuccess value)? success,
    TResult Function(DartRemoteConfigStateFailure value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DartRemoteConfigStateSuccess value)? success,
    TResult Function(DartRemoteConfigStateFailure value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DartRemoteConfigStateCopyWith<$Res> {
  factory $DartRemoteConfigStateCopyWith(DartRemoteConfigState value,
          $Res Function(DartRemoteConfigState) then) =
      _$DartRemoteConfigStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$DartRemoteConfigStateCopyWithImpl<$Res>
    implements $DartRemoteConfigStateCopyWith<$Res> {
  _$DartRemoteConfigStateCopyWithImpl(this._value, this._then);

  final DartRemoteConfigState _value;
  // ignore: unused_field
  final $Res Function(DartRemoteConfigState) _then;
}

/// @nodoc
abstract class _$$DartRemoteConfigStateSuccessCopyWith<$Res> {
  factory _$$DartRemoteConfigStateSuccessCopyWith(
          _$DartRemoteConfigStateSuccess value,
          $Res Function(_$DartRemoteConfigStateSuccess) then) =
      __$$DartRemoteConfigStateSuccessCopyWithImpl<$Res>;
  $Res call({RemoteConfig config, ExperimentationEngineResult experiments});

  $ExperimentationEngineResultCopyWith<$Res> get experiments;
}

/// @nodoc
class __$$DartRemoteConfigStateSuccessCopyWithImpl<$Res>
    extends _$DartRemoteConfigStateCopyWithImpl<$Res>
    implements _$$DartRemoteConfigStateSuccessCopyWith<$Res> {
  __$$DartRemoteConfigStateSuccessCopyWithImpl(
      _$DartRemoteConfigStateSuccess _value,
      $Res Function(_$DartRemoteConfigStateSuccess) _then)
      : super(_value, (v) => _then(v as _$DartRemoteConfigStateSuccess));

  @override
  _$DartRemoteConfigStateSuccess get _value =>
      super._value as _$DartRemoteConfigStateSuccess;

  @override
  $Res call({
    Object? config = freezed,
    Object? experiments = freezed,
  }) {
    return _then(_$DartRemoteConfigStateSuccess(
      config: config == freezed
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as RemoteConfig,
      experiments: experiments == freezed
          ? _value.experiments
          : experiments // ignore: cast_nullable_to_non_nullable
              as ExperimentationEngineResult,
    ));
  }

  @override
  $ExperimentationEngineResultCopyWith<$Res> get experiments {
    return $ExperimentationEngineResultCopyWith<$Res>(_value.experiments,
        (value) {
      return _then(_value.copyWith(experiments: value));
    });
  }
}

/// @nodoc

class _$DartRemoteConfigStateSuccess implements DartRemoteConfigStateSuccess {
  const _$DartRemoteConfigStateSuccess(
      {required this.config, required this.experiments});

  @override
  final RemoteConfig config;
  @override
  final ExperimentationEngineResult experiments;

  @override
  String toString() {
    return 'DartRemoteConfigState.success(config: $config, experiments: $experiments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DartRemoteConfigStateSuccess &&
            const DeepCollectionEquality().equals(other.config, config) &&
            const DeepCollectionEquality()
                .equals(other.experiments, experiments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(config),
      const DeepCollectionEquality().hash(experiments));

  @JsonKey(ignore: true)
  @override
  _$$DartRemoteConfigStateSuccessCopyWith<_$DartRemoteConfigStateSuccess>
      get copyWith => __$$DartRemoteConfigStateSuccessCopyWithImpl<
          _$DartRemoteConfigStateSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RemoteConfig config, ExperimentationEngineResult experiments)
        success,
    required TResult Function(DartRemoteConfigStatus status,
            RemoteConfigResponseFailure? fetcherError)
        failed,
  }) {
    return success(config, experiments);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            RemoteConfig config, ExperimentationEngineResult experiments)?
        success,
    TResult Function(DartRemoteConfigStatus status,
            RemoteConfigResponseFailure? fetcherError)?
        failed,
  }) {
    return success?.call(config, experiments);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RemoteConfig config, ExperimentationEngineResult experiments)?
        success,
    TResult Function(DartRemoteConfigStatus status,
            RemoteConfigResponseFailure? fetcherError)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(config, experiments);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DartRemoteConfigStateSuccess value) success,
    required TResult Function(DartRemoteConfigStateFailure value) failed,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(DartRemoteConfigStateSuccess value)? success,
    TResult Function(DartRemoteConfigStateFailure value)? failed,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DartRemoteConfigStateSuccess value)? success,
    TResult Function(DartRemoteConfigStateFailure value)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class DartRemoteConfigStateSuccess implements DartRemoteConfigState {
  const factory DartRemoteConfigStateSuccess(
          {required final RemoteConfig config,
          required final ExperimentationEngineResult experiments}) =
      _$DartRemoteConfigStateSuccess;

  RemoteConfig get config => throw _privateConstructorUsedError;
  ExperimentationEngineResult get experiments =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$DartRemoteConfigStateSuccessCopyWith<_$DartRemoteConfigStateSuccess>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DartRemoteConfigStateFailureCopyWith<$Res> {
  factory _$$DartRemoteConfigStateFailureCopyWith(
          _$DartRemoteConfigStateFailure value,
          $Res Function(_$DartRemoteConfigStateFailure) then) =
      __$$DartRemoteConfigStateFailureCopyWithImpl<$Res>;
  $Res call(
      {DartRemoteConfigStatus status,
      RemoteConfigResponseFailure? fetcherError});
}

/// @nodoc
class __$$DartRemoteConfigStateFailureCopyWithImpl<$Res>
    extends _$DartRemoteConfigStateCopyWithImpl<$Res>
    implements _$$DartRemoteConfigStateFailureCopyWith<$Res> {
  __$$DartRemoteConfigStateFailureCopyWithImpl(
      _$DartRemoteConfigStateFailure _value,
      $Res Function(_$DartRemoteConfigStateFailure) _then)
      : super(_value, (v) => _then(v as _$DartRemoteConfigStateFailure));

  @override
  _$DartRemoteConfigStateFailure get _value =>
      super._value as _$DartRemoteConfigStateFailure;

  @override
  $Res call({
    Object? status = freezed,
    Object? fetcherError = freezed,
  }) {
    return _then(_$DartRemoteConfigStateFailure(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DartRemoteConfigStatus,
      fetcherError: fetcherError == freezed
          ? _value.fetcherError
          : fetcherError // ignore: cast_nullable_to_non_nullable
              as RemoteConfigResponseFailure?,
    ));
  }
}

/// @nodoc

class _$DartRemoteConfigStateFailure implements DartRemoteConfigStateFailure {
  const _$DartRemoteConfigStateFailure(
      {required this.status, this.fetcherError});

  @override
  final DartRemoteConfigStatus status;
  @override
  final RemoteConfigResponseFailure? fetcherError;

  @override
  String toString() {
    return 'DartRemoteConfigState.failed(status: $status, fetcherError: $fetcherError)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DartRemoteConfigStateFailure &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.fetcherError, fetcherError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(fetcherError));

  @JsonKey(ignore: true)
  @override
  _$$DartRemoteConfigStateFailureCopyWith<_$DartRemoteConfigStateFailure>
      get copyWith => __$$DartRemoteConfigStateFailureCopyWithImpl<
          _$DartRemoteConfigStateFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RemoteConfig config, ExperimentationEngineResult experiments)
        success,
    required TResult Function(DartRemoteConfigStatus status,
            RemoteConfigResponseFailure? fetcherError)
        failed,
  }) {
    return failed(status, fetcherError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            RemoteConfig config, ExperimentationEngineResult experiments)?
        success,
    TResult Function(DartRemoteConfigStatus status,
            RemoteConfigResponseFailure? fetcherError)?
        failed,
  }) {
    return failed?.call(status, fetcherError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RemoteConfig config, ExperimentationEngineResult experiments)?
        success,
    TResult Function(DartRemoteConfigStatus status,
            RemoteConfigResponseFailure? fetcherError)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(status, fetcherError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DartRemoteConfigStateSuccess value) success,
    required TResult Function(DartRemoteConfigStateFailure value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(DartRemoteConfigStateSuccess value)? success,
    TResult Function(DartRemoteConfigStateFailure value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DartRemoteConfigStateSuccess value)? success,
    TResult Function(DartRemoteConfigStateFailure value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class DartRemoteConfigStateFailure implements DartRemoteConfigState {
  const factory DartRemoteConfigStateFailure(
          {required final DartRemoteConfigStatus status,
          final RemoteConfigResponseFailure? fetcherError}) =
      _$DartRemoteConfigStateFailure;

  DartRemoteConfigStatus get status => throw _privateConstructorUsedError;
  RemoteConfigResponseFailure? get fetcherError =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$DartRemoteConfigStateFailureCopyWith<_$DartRemoteConfigStateFailure>
      get copyWith => throw _privateConstructorUsedError;
}
