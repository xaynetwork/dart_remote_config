import 'package:json_annotation/json_annotation.dart';

part 'known_experiment_variant.g.dart';

@JsonSerializable()
class KnownVariantId {
  final String experimentId;
  final String? variantId;
  final double size;

  const KnownVariantId(this.experimentId, this.variantId, this.size);

  bool get isSubscribed => variantId != null;

  factory KnownVariantId.fromJson(dynamic json) =>
      _$KnownVariantIdFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$KnownVariantIdToJson(this);

  @override
  String toString() => '$experimentId.$variantId:$size';
}
