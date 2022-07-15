// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'experimentation_engine_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExperimentResult _$ExperimentResultFromJson(Map<String, dynamic> json) {
  return _ExperimentInstance.fromJson(json);
}

/// @nodoc
mixin _$ExperimentResult {
  Experiment get experiment => throw _privateConstructorUsedError;
  Variant get initialSelectedVariant => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExperimentResultCopyWith<ExperimentResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperimentResultCopyWith<$Res> {
  factory $ExperimentResultCopyWith(
          ExperimentResult value, $Res Function(ExperimentResult) then) =
      _$ExperimentResultCopyWithImpl<$Res>;
  $Res call({Experiment experiment, Variant initialSelectedVariant});
}

/// @nodoc
class _$ExperimentResultCopyWithImpl<$Res>
    implements $ExperimentResultCopyWith<$Res> {
  _$ExperimentResultCopyWithImpl(this._value, this._then);

  final ExperimentResult _value;
  // ignore: unused_field
  final $Res Function(ExperimentResult) _then;

  @override
  $Res call({
    Object? experiment = freezed,
    Object? initialSelectedVariant = freezed,
  }) {
    return _then(_value.copyWith(
      experiment: experiment == freezed
          ? _value.experiment
          : experiment // ignore: cast_nullable_to_non_nullable
              as Experiment,
      initialSelectedVariant: initialSelectedVariant == freezed
          ? _value.initialSelectedVariant
          : initialSelectedVariant // ignore: cast_nullable_to_non_nullable
              as Variant,
    ));
  }
}

/// @nodoc
abstract class _$$_ExperimentInstanceCopyWith<$Res>
    implements $ExperimentResultCopyWith<$Res> {
  factory _$$_ExperimentInstanceCopyWith(_$_ExperimentInstance value,
          $Res Function(_$_ExperimentInstance) then) =
      __$$_ExperimentInstanceCopyWithImpl<$Res>;
  @override
  $Res call({Experiment experiment, Variant initialSelectedVariant});
}

/// @nodoc
class __$$_ExperimentInstanceCopyWithImpl<$Res>
    extends _$ExperimentResultCopyWithImpl<$Res>
    implements _$$_ExperimentInstanceCopyWith<$Res> {
  __$$_ExperimentInstanceCopyWithImpl(
      _$_ExperimentInstance _value, $Res Function(_$_ExperimentInstance) _then)
      : super(_value, (v) => _then(v as _$_ExperimentInstance));

  @override
  _$_ExperimentInstance get _value => super._value as _$_ExperimentInstance;

  @override
  $Res call({
    Object? experiment = freezed,
    Object? initialSelectedVariant = freezed,
  }) {
    return _then(_$_ExperimentInstance(
      experiment: experiment == freezed
          ? _value.experiment
          : experiment // ignore: cast_nullable_to_non_nullable
              as Experiment,
      initialSelectedVariant: initialSelectedVariant == freezed
          ? _value.initialSelectedVariant
          : initialSelectedVariant // ignore: cast_nullable_to_non_nullable
              as Variant,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExperimentInstance implements _ExperimentInstance {
  const _$_ExperimentInstance(
      {required this.experiment, required this.initialSelectedVariant});

  factory _$_ExperimentInstance.fromJson(Map<String, dynamic> json) =>
      _$$_ExperimentInstanceFromJson(json);

  @override
  final Experiment experiment;
  @override
  final Variant initialSelectedVariant;

  @override
  String toString() {
    return 'ExperimentResult(experiment: $experiment, initialSelectedVariant: $initialSelectedVariant)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExperimentInstance &&
            const DeepCollectionEquality()
                .equals(other.experiment, experiment) &&
            const DeepCollectionEquality()
                .equals(other.initialSelectedVariant, initialSelectedVariant));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(experiment),
      const DeepCollectionEquality().hash(initialSelectedVariant));

  @JsonKey(ignore: true)
  @override
  _$$_ExperimentInstanceCopyWith<_$_ExperimentInstance> get copyWith =>
      __$$_ExperimentInstanceCopyWithImpl<_$_ExperimentInstance>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExperimentInstanceToJson(this);
  }
}

abstract class _ExperimentInstance implements ExperimentResult {
  const factory _ExperimentInstance(
      {required final Experiment experiment,
      required final Variant initialSelectedVariant}) = _$_ExperimentInstance;

  factory _ExperimentInstance.fromJson(Map<String, dynamic> json) =
      _$_ExperimentInstance.fromJson;

  @override
  Experiment get experiment => throw _privateConstructorUsedError;
  @override
  Variant get initialSelectedVariant => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ExperimentInstanceCopyWith<_$_ExperimentInstance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExperimentationEngineResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Set<ExperimentResult> subscribedExperiments, List<Feature> features)
        success,
    required TResult Function(
            ExperimentationEngineResultError error, String? message)
        failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Set<ExperimentResult> subscribedExperiments,
            List<Feature> features)?
        success,
    TResult Function(ExperimentationEngineResultError error, String? message)?
        failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Set<ExperimentResult> subscribedExperiments,
            List<Feature> features)?
        success,
    TResult Function(ExperimentationEngineResultError error, String? message)?
        failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExperimentationEngineResultSuccess value) success,
    required TResult Function(ExperimentationEngineResultFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ExperimentationEngineResultSuccess value)? success,
    TResult Function(ExperimentationEngineResultFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExperimentationEngineResultSuccess value)? success,
    TResult Function(ExperimentationEngineResultFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperimentationEngineResultCopyWith<$Res> {
  factory $ExperimentationEngineResultCopyWith(
          ExperimentationEngineResult value,
          $Res Function(ExperimentationEngineResult) then) =
      _$ExperimentationEngineResultCopyWithImpl<$Res>;
}

/// @nodoc
class _$ExperimentationEngineResultCopyWithImpl<$Res>
    implements $ExperimentationEngineResultCopyWith<$Res> {
  _$ExperimentationEngineResultCopyWithImpl(this._value, this._then);

  final ExperimentationEngineResult _value;
  // ignore: unused_field
  final $Res Function(ExperimentationEngineResult) _then;
}

/// @nodoc
abstract class _$$ExperimentationEngineResultSuccessCopyWith<$Res> {
  factory _$$ExperimentationEngineResultSuccessCopyWith(
          _$ExperimentationEngineResultSuccess value,
          $Res Function(_$ExperimentationEngineResultSuccess) then) =
      __$$ExperimentationEngineResultSuccessCopyWithImpl<$Res>;
  $Res call(
      {Set<ExperimentResult> subscribedExperiments, List<Feature> features});
}

/// @nodoc
class __$$ExperimentationEngineResultSuccessCopyWithImpl<$Res>
    extends _$ExperimentationEngineResultCopyWithImpl<$Res>
    implements _$$ExperimentationEngineResultSuccessCopyWith<$Res> {
  __$$ExperimentationEngineResultSuccessCopyWithImpl(
      _$ExperimentationEngineResultSuccess _value,
      $Res Function(_$ExperimentationEngineResultSuccess) _then)
      : super(_value, (v) => _then(v as _$ExperimentationEngineResultSuccess));

  @override
  _$ExperimentationEngineResultSuccess get _value =>
      super._value as _$ExperimentationEngineResultSuccess;

  @override
  $Res call({
    Object? subscribedExperiments = freezed,
    Object? features = freezed,
  }) {
    return _then(_$ExperimentationEngineResultSuccess(
      subscribedExperiments == freezed
          ? _value._subscribedExperiments
          : subscribedExperiments // ignore: cast_nullable_to_non_nullable
              as Set<ExperimentResult>,
      features == freezed
          ? _value._features
          : features // ignore: cast_nullable_to_non_nullable
              as List<Feature>,
    ));
  }
}

/// @nodoc

class _$ExperimentationEngineResultSuccess
    implements ExperimentationEngineResultSuccess {
  const _$ExperimentationEngineResultSuccess(
      final Set<ExperimentResult> subscribedExperiments,
      final List<Feature> features)
      : _subscribedExperiments = subscribedExperiments,
        _features = features;

  final Set<ExperimentResult> _subscribedExperiments;
  @override
  Set<ExperimentResult> get subscribedExperiments {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_subscribedExperiments);
  }

  final List<Feature> _features;
  @override
  List<Feature> get features {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  String toString() {
    return 'ExperimentationEngineResult.success(subscribedExperiments: $subscribedExperiments, features: $features)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperimentationEngineResultSuccess &&
            const DeepCollectionEquality()
                .equals(other._subscribedExperiments, _subscribedExperiments) &&
            const DeepCollectionEquality().equals(other._features, _features));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_subscribedExperiments),
      const DeepCollectionEquality().hash(_features));

  @JsonKey(ignore: true)
  @override
  _$$ExperimentationEngineResultSuccessCopyWith<
          _$ExperimentationEngineResultSuccess>
      get copyWith => __$$ExperimentationEngineResultSuccessCopyWithImpl<
          _$ExperimentationEngineResultSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Set<ExperimentResult> subscribedExperiments, List<Feature> features)
        success,
    required TResult Function(
            ExperimentationEngineResultError error, String? message)
        failure,
  }) {
    return success(subscribedExperiments, features);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Set<ExperimentResult> subscribedExperiments,
            List<Feature> features)?
        success,
    TResult Function(ExperimentationEngineResultError error, String? message)?
        failure,
  }) {
    return success?.call(subscribedExperiments, features);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Set<ExperimentResult> subscribedExperiments,
            List<Feature> features)?
        success,
    TResult Function(ExperimentationEngineResultError error, String? message)?
        failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(subscribedExperiments, features);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExperimentationEngineResultSuccess value) success,
    required TResult Function(ExperimentationEngineResultFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ExperimentationEngineResultSuccess value)? success,
    TResult Function(ExperimentationEngineResultFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExperimentationEngineResultSuccess value)? success,
    TResult Function(ExperimentationEngineResultFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ExperimentationEngineResultSuccess
    implements ExperimentationEngineResult {
  const factory ExperimentationEngineResultSuccess(
      final Set<ExperimentResult> subscribedExperiments,
      final List<Feature> features) = _$ExperimentationEngineResultSuccess;

  Set<ExperimentResult> get subscribedExperiments =>
      throw _privateConstructorUsedError;
  List<Feature> get features => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$ExperimentationEngineResultSuccessCopyWith<
          _$ExperimentationEngineResultSuccess>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExperimentationEngineResultFailureCopyWith<$Res> {
  factory _$$ExperimentationEngineResultFailureCopyWith(
          _$ExperimentationEngineResultFailure value,
          $Res Function(_$ExperimentationEngineResultFailure) then) =
      __$$ExperimentationEngineResultFailureCopyWithImpl<$Res>;
  $Res call({ExperimentationEngineResultError error, String? message});
}

/// @nodoc
class __$$ExperimentationEngineResultFailureCopyWithImpl<$Res>
    extends _$ExperimentationEngineResultCopyWithImpl<$Res>
    implements _$$ExperimentationEngineResultFailureCopyWith<$Res> {
  __$$ExperimentationEngineResultFailureCopyWithImpl(
      _$ExperimentationEngineResultFailure _value,
      $Res Function(_$ExperimentationEngineResultFailure) _then)
      : super(_value, (v) => _then(v as _$ExperimentationEngineResultFailure));

  @override
  _$ExperimentationEngineResultFailure get _value =>
      super._value as _$ExperimentationEngineResultFailure;

  @override
  $Res call({
    Object? error = freezed,
    Object? message = freezed,
  }) {
    return _then(_$ExperimentationEngineResultFailure(
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ExperimentationEngineResultError,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ExperimentationEngineResultFailure
    implements ExperimentationEngineResultFailure {
  const _$ExperimentationEngineResultFailure(
      {required this.error, this.message});

  @override
  final ExperimentationEngineResultError error;
  @override
  final String? message;

  @override
  String toString() {
    return 'ExperimentationEngineResult.failure(error: $error, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperimentationEngineResultFailure &&
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
  _$$ExperimentationEngineResultFailureCopyWith<
          _$ExperimentationEngineResultFailure>
      get copyWith => __$$ExperimentationEngineResultFailureCopyWithImpl<
          _$ExperimentationEngineResultFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Set<ExperimentResult> subscribedExperiments, List<Feature> features)
        success,
    required TResult Function(
            ExperimentationEngineResultError error, String? message)
        failure,
  }) {
    return failure(error, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Set<ExperimentResult> subscribedExperiments,
            List<Feature> features)?
        success,
    TResult Function(ExperimentationEngineResultError error, String? message)?
        failure,
  }) {
    return failure?.call(error, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Set<ExperimentResult> subscribedExperiments,
            List<Feature> features)?
        success,
    TResult Function(ExperimentationEngineResultError error, String? message)?
        failure,
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
    required TResult Function(ExperimentationEngineResultSuccess value) success,
    required TResult Function(ExperimentationEngineResultFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ExperimentationEngineResultSuccess value)? success,
    TResult Function(ExperimentationEngineResultFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExperimentationEngineResultSuccess value)? success,
    TResult Function(ExperimentationEngineResultFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class ExperimentationEngineResultFailure
    implements ExperimentationEngineResult {
  const factory ExperimentationEngineResultFailure(
      {required final ExperimentationEngineResultError error,
      final String? message}) = _$ExperimentationEngineResultFailure;

  ExperimentationEngineResultError get error =>
      throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$ExperimentationEngineResultFailureCopyWith<
          _$ExperimentationEngineResultFailure>
      get copyWith => throw _privateConstructorUsedError;
}