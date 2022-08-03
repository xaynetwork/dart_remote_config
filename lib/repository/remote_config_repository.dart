import 'package:dart_remote_config/model/known_experiment_variant.dart';
import 'package:hive/hive.dart';

const _kBoxKey = 'RemoteConfigBox';
const _kExperimentationResultKey = 'ExperimentationResult';
const _kRemoteConfigKey = 'RemoteConfig';

abstract class RemoteConfigRepository {
  Future<void> saveSubscribedVariantsIds(
    Set<KnownVariantId> subscribedVariantIds,
  );

  Future<Set<KnownVariantId>> readSubscribedVariantIds();
}

class HiveRemoteConfigRepository extends RemoteConfigRepository {
  @override
  Future<void> saveSubscribedVariantsIds(
    Set<KnownVariantId> subscribedVariantIds,
  ) async {
    if (subscribedVariantIds.isEmpty) return;
    final box = await _getBox();
    await box.put(
      _kExperimentationResultKey,
      subscribedVariantIds.map((it) => it.toJson()),
    );
  }

  @override
  Future<Set<KnownVariantId>> readSubscribedVariantIds() async {
    final box = await _getBox();
    if (!box.containsKey(_kExperimentationResultKey)) return <KnownVariantId>{};
    final idSet = await box.get(_kExperimentationResultKey)
        as Iterable<Map<String, dynamic>>;
    return idSet.map((it) => KnownVariantId.fromJson(it)).toSet();
  }

  Future<LazyBox> _getBox() => Hive.openLazyBox(_kBoxKey);
}
