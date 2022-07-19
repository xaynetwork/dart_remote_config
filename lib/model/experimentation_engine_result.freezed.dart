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
  switch (json['runtimeType']) {
    case 'subscribed':
      return ExperimentResultSubscribed.fromJson(json);
    case 'notSubscribed':
      return ExperimentResultNotSubscribed.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ExperimentResult',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ExperimentResult {
  Experiment get experiment => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Experiment experiment, Variant initialSelectedVariant)
        subscribed,
    required TResult Function(Experiment experiment) notSubscribed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Experiment experiment, Variant initialSelectedVariant)?
        subscribed,
    TResult Function(Experiment experiment)? notSubscribed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Experiment experiment, Variant initialSelectedVariant)?
        subscribed,
    TResult Function(Experiment experiment)? notSubscribed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExperimentResultSubscribed value) subscribed,
    required TResult Function(ExperimentResultNotSubscribed value)
        notSubscribed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ExperimentResultSubscribed value)? subscribed,
    TResult Function(ExperimentResultNotSubscribed value)? notSubscribed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExperimentResultSubscribed value)? subscribed,
    TResult Function(ExperimentResultNotSubscribed value)? notSubscribed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
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
  $Res call({Experiment experiment});
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
  }) {
    return _then(_value.copyWith(
      experiment: experiment == freezed
          ? _value.experiment
          : experiment // ignore: cast_nullable_to_non_nullable
              as Experiment,
    ));
  }
}

/// @nodoc
abstract class _$$ExperimentResultSubscribedCopyWith<$Res>
    implements $ExperimentResultCopyWith<$Res> {
  factory _$$ExperimentResultSubscribedCopyWith(
          _$ExperimentResultSubscribed value,
          $Res Function(_$ExperimentResultSubscribed) then) =
      __$$ExperimentResultSubscribedCopyWithImpl<$Res>;
  @override
  $Res call({Experiment experiment, Variant initialSelectedVariant});
}

/// @nodoc
class __$$ExperimentResultSubscribedCopyWithImpl<$Res>
    extends _$ExperimentResultCopyWithImpl<$Res>
    implements _$$ExperimentResultSubscribedCopyWith<$Res> {
  __$$ExperimentResultSubscribedCopyWithImpl(
      _$ExperimentResultSubscribed _value,
      $Res Function(_$ExperimentResultSubscribed) _then)
      : super(_value, (v) => _then(v as _$ExperimentResultSubscribed));

  @override
  _$ExperimentResultSubscribed get _value =>
      super._value as _$ExperimentResultSubscribed;

  @override
  $Res call({
    Object? experiment = freezed,
    Object? initialSelectedVariant = freezed,
  }) {
    return _then(_$ExperimentResultSubscribed(
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
class _$ExperimentResultSubscribed implements ExperimentResultSubscribed {
  const _$ExperimentResultSubscribed(
      {required this.experiment,
      required this.initialSelectedVariant,
      final String? $type})
      : $type = $type ?? 'subscribed';

  factory _$ExperimentResultSubscribed.fromJson(Map<String, dynamic> json) =>
      _$$ExperimentResultSubscribedFromJson(json);

  @override
  final Experiment experiment;
  @override
  final Variant initialSelectedVariant;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ExperimentResult.subscribed(experiment: $experiment, initialSelectedVariant: $initialSelectedVariant)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperimentResultSubscribed &&
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
  _$$ExperimentResultSubscribedCopyWith<_$ExperimentResultSubscribed>
      get copyWith => __$$ExperimentResultSubscribedCopyWithImpl<
          _$ExperimentResultSubscribed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Experiment experiment, Variant initialSelectedVariant)
        subscribed,
    required TResult Function(Experiment experiment) notSubscribed,
  }) {
    return subscribed(experiment, initialSelectedVariant);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Experiment experiment, Variant initialSelectedVariant)?
        subscribed,
    TResult Function(Experiment experiment)? notSubscribed,
  }) {
    return subscribed?.call(experiment, initialSelectedVariant);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Experiment experiment, Variant initialSelectedVariant)?
        subscribed,
    TResult Function(Experiment experiment)? notSubscribed,
    required TResult orElse(),
  }) {
    if (subscribed != null) {
      return subscribed(experiment, initialSelectedVariant);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExperimentResultSubscribed value) subscribed,
    required TResult Function(ExperimentResultNotSubscribed value)
        notSubscribed,
  }) {
    return subscribed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ExperimentResultSubscribed value)? subscribed,
    TResult Function(ExperimentResultNotSubscribed value)? notSubscribed,
  }) {
    return subscribed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExperimentResultSubscribed value)? subscribed,
    TResult Function(ExperimentResultNotSubscribed value)? notSubscribed,
    required TResult orElse(),
  }) {
    if (subscribed != null) {
      return subscribed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperimentResultSubscribedToJson(this);
  }
}

abstract class ExperimentResultSubscribed implements ExperimentResult {
  const factory ExperimentResultSubscribed(
          {required final Experiment experiment,
          required final Variant initialSelectedVariant}) =
      _$ExperimentResultSubscribed;

  factory ExperimentResultSubscribed.fromJson(Map<String, dynamic> json) =
      _$ExperimentResultSubscribed.fromJson;

  @override
  Experiment get experiment => throw _privateConstructorUsedError;
  Variant get initialSelectedVariant => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$ExperimentResultSubscribedCopyWith<_$ExperimentResultSubscribed>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExperimentResultNotSubscribedCopyWith<$Res>
    implements $ExperimentResultCopyWith<$Res> {
  factory _$$ExperimentResultNotSubscribedCopyWith(
          _$ExperimentResultNotSubscribed value,
          $Res Function(_$ExperimentResultNotSubscribed) then) =
      __$$ExperimentResultNotSubscribedCopyWithImpl<$Res>;
  @override
  $Res call({Experiment experiment});
}

/// @nodoc
class __$$ExperimentResultNotSubscribedCopyWithImpl<$Res>
    extends _$ExperimentResultCopyWithImpl<$Res>
    implements _$$ExperimentResultNotSubscribedCopyWith<$Res> {
  __$$ExperimentResultNotSubscribedCopyWithImpl(
      _$ExperimentResultNotSubscribed _value,
      $Res Function(_$ExperimentResultNotSubscribed) _then)
      : super(_value, (v) => _then(v as _$ExperimentResultNotSubscribed));

  @override
  _$ExperimentResultNotSubscribed get _value =>
      super._value as _$ExperimentResultNotSubscribed;

  @override
  $Res call({
    Object? experiment = freezed,
  }) {
    return _then(_$ExperimentResultNotSubscribed(
      experiment: experiment == freezed
          ? _value.experiment
          : experiment // ignore: cast_nullable_to_non_nullable
              as Experiment,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExperimentResultNotSubscribed implements ExperimentResultNotSubscribed {
  const _$ExperimentResultNotSubscribed(
      {required this.experiment, final String? $type})
      : $type = $type ?? 'notSubscribed';

  factory _$ExperimentResultNotSubscribed.fromJson(Map<String, dynamic> json) =>
      _$$ExperimentResultNotSubscribedFromJson(json);

  @override
  final Experiment experiment;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ExperimentResult.notSubscribed(experiment: $experiment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperimentResultNotSubscribed &&
            const DeepCollectionEquality()
                .equals(other.experiment, experiment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(experiment));

  @JsonKey(ignore: true)
  @override
  _$$ExperimentResultNotSubscribedCopyWith<_$ExperimentResultNotSubscribed>
      get copyWith => __$$ExperimentResultNotSubscribedCopyWithImpl<
          _$ExperimentResultNotSubscribed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Experiment experiment, Variant initialSelectedVariant)
        subscribed,
    required TResult Function(Experiment experiment) notSubscribed,
  }) {
    return notSubscribed(experiment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Experiment experiment, Variant initialSelectedVariant)?
        subscribed,
    TResult Function(Experiment experiment)? notSubscribed,
  }) {
    return notSubscribed?.call(experiment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Experiment experiment, Variant initialSelectedVariant)?
        subscribed,
    TResult Function(Experiment experiment)? notSubscribed,
    required TResult orElse(),
  }) {
    if (notSubscribed != null) {
      return notSubscribed(experiment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExperimentResultSubscribed value) subscribed,
    required TResult Function(ExperimentResultNotSubscribed value)
        notSubscribed,
  }) {
    return notSubscribed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ExperimentResultSubscribed value)? subscribed,
    TResult Function(ExperimentResultNotSubscribed value)? notSubscribed,
  }) {
    return notSubscribed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExperimentResultSubscribed value)? subscribed,
    TResult Function(ExperimentResultNotSubscribed value)? notSubscribed,
    required TResult orElse(),
  }) {
    if (notSubscribed != null) {
      return notSubscribed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperimentResultNotSubscribedToJson(this);
  }
}

abstract class ExperimentResultNotSubscribed implements ExperimentResult {
  const factory ExperimentResultNotSubscribed(
      {required final Experiment experiment}) = _$ExperimentResultNotSubscribed;

  factory ExperimentResultNotSubscribed.fromJson(Map<String, dynamic> json) =
      _$ExperimentResultNotSubscribed.fromJson;

  @override
  Experiment get experiment => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$ExperimentResultNotSubscribedCopyWith<_$ExperimentResultNotSubscribed>
      get copyWith => throw _privateConstructorUsedError;
}

ExperimentationEngineResult _$ExperimentationEngineResultFromJson(
    Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'success':
      return ExperimentationEngineResultSuccess.fromJson(json);
    case 'failure':
      return ExperimentationEngineResultFailure.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'ExperimentationEngineResult',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ExperimentationEngineResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Set<ExperimentResult> computedExperiments,
            List<Feature> featuresDefinedInConfig)
        success,
    required TResult Function(
            ExperimentationEngineResultError error, String? message)
        failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Set<ExperimentResult> computedExperiments,
            List<Feature> featuresDefinedInConfig)?
        success,
    TResult Function(ExperimentationEngineResultError error, String? message)?
        failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Set<ExperimentResult> computedExperiments,
            List<Feature> featuresDefinedInConfig)?
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
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
      {Set<ExperimentResult> computedExperiments,
      List<Feature> featuresDefinedInConfig});
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
    Object? computedExperiments = freezed,
    Object? featuresDefinedInConfig = freezed,
  }) {
    return _then(_$ExperimentationEngineResultSuccess(
      computedExperiments == freezed
          ? _value._computedExperiments
          : computedExperiments // ignore: cast_nullable_to_non_nullable
              as Set<ExperimentResult>,
      featuresDefinedInConfig == freezed
          ? _value._featuresDefinedInConfig
          : featuresDefinedInConfig // ignore: cast_nullable_to_non_nullable
              as List<Feature>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExperimentationEngineResultSuccess
    implements ExperimentationEngineResultSuccess {
  const _$ExperimentationEngineResultSuccess(
      final Set<ExperimentResult> computedExperiments,
      final List<Feature> featuresDefinedInConfig,
      {final String? $type})
      : _computedExperiments = computedExperiments,
        _featuresDefinedInConfig = featuresDefinedInConfig,
        $type = $type ?? 'success';

  factory _$ExperimentationEngineResultSuccess.fromJson(
          Map<String, dynamic> json) =>
      _$$ExperimentationEngineResultSuccessFromJson(json);

  final Set<ExperimentResult> _computedExperiments;
  @override
  Set<ExperimentResult> get computedExperiments {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_computedExperiments);
  }

  final List<Feature> _featuresDefinedInConfig;
  @override
  List<Feature> get featuresDefinedInConfig {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_featuresDefinedInConfig);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ExperimentationEngineResult.success(computedExperiments: $computedExperiments, featuresDefinedInConfig: $featuresDefinedInConfig)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperimentationEngineResultSuccess &&
            const DeepCollectionEquality()
                .equals(other._computedExperiments, _computedExperiments) &&
            const DeepCollectionEquality().equals(
                other._featuresDefinedInConfig, _featuresDefinedInConfig));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_computedExperiments),
      const DeepCollectionEquality().hash(_featuresDefinedInConfig));

  @JsonKey(ignore: true)
  @override
  _$$ExperimentationEngineResultSuccessCopyWith<
          _$ExperimentationEngineResultSuccess>
      get copyWith => __$$ExperimentationEngineResultSuccessCopyWithImpl<
          _$ExperimentationEngineResultSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Set<ExperimentResult> computedExperiments,
            List<Feature> featuresDefinedInConfig)
        success,
    required TResult Function(
            ExperimentationEngineResultError error, String? message)
        failure,
  }) {
    return success(computedExperiments, featuresDefinedInConfig);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Set<ExperimentResult> computedExperiments,
            List<Feature> featuresDefinedInConfig)?
        success,
    TResult Function(ExperimentationEngineResultError error, String? message)?
        failure,
  }) {
    return success?.call(computedExperiments, featuresDefinedInConfig);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Set<ExperimentResult> computedExperiments,
            List<Feature> featuresDefinedInConfig)?
        success,
    TResult Function(ExperimentationEngineResultError error, String? message)?
        failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(computedExperiments, featuresDefinedInConfig);
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

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperimentationEngineResultSuccessToJson(this);
  }
}

abstract class ExperimentationEngineResultSuccess
    implements ExperimentationEngineResult {
  const factory ExperimentationEngineResultSuccess(
          final Set<ExperimentResult> computedExperiments,
          final List<Feature> featuresDefinedInConfig) =
      _$ExperimentationEngineResultSuccess;

  factory ExperimentationEngineResultSuccess.fromJson(
          Map<String, dynamic> json) =
      _$ExperimentationEngineResultSuccess.fromJson;

  Set<ExperimentResult> get computedExperiments =>
      throw _privateConstructorUsedError;
  List<Feature> get featuresDefinedInConfig =>
      throw _privateConstructorUsedError;
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
@JsonSerializable()
class _$ExperimentationEngineResultFailure
    implements ExperimentationEngineResultFailure {
  const _$ExperimentationEngineResultFailure(
      {required this.error, this.message, final String? $type})
      : $type = $type ?? 'failure';

  factory _$ExperimentationEngineResultFailure.fromJson(
          Map<String, dynamic> json) =>
      _$$ExperimentationEngineResultFailureFromJson(json);

  @override
  final ExperimentationEngineResultError error;
  @override
  final String? message;

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(ignore: true)
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
    required TResult Function(Set<ExperimentResult> computedExperiments,
            List<Feature> featuresDefinedInConfig)
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
    TResult Function(Set<ExperimentResult> computedExperiments,
            List<Feature> featuresDefinedInConfig)?
        success,
    TResult Function(ExperimentationEngineResultError error, String? message)?
        failure,
  }) {
    return failure?.call(error, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Set<ExperimentResult> computedExperiments,
            List<Feature> featuresDefinedInConfig)?
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

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperimentationEngineResultFailureToJson(this);
  }
}

abstract class ExperimentationEngineResultFailure
    implements ExperimentationEngineResult {
  const factory ExperimentationEngineResultFailure(
      {required final ExperimentationEngineResultError error,
      final String? message}) = _$ExperimentationEngineResultFailure;

  factory ExperimentationEngineResultFailure.fromJson(
          Map<String, dynamic> json) =
      _$ExperimentationEngineResultFailure.fromJson;

  ExperimentationEngineResultError get error =>
      throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$ExperimentationEngineResultFailureCopyWith<
          _$ExperimentationEngineResultFailure>
      get copyWith => throw _privateConstructorUsedError;
}
