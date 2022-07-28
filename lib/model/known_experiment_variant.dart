import 'package:json_annotation/json_annotation.dart';

part 'known_experiment_variant.g.dart';

@JsonSerializable()
class KnownVariantId {
  final String experimentId;
  final String? variantId;

  const KnownVariantId(this.experimentId, this.variantId);

  bool get isSubscribed => variantId != null;

  factory KnownVariantId.fromJson(Map<String, dynamic> json) =>
      _$KnownExperimentVariantFromJson(json);

  Map<String, dynamic> toJson() => _$KnownExperimentVariantToJson(this);
}
