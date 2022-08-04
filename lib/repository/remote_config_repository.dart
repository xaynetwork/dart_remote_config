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

  Future saveRemoteConfig(String remoteConfig);

  Future<String?> readRemoteConfig();
}

class HiveRemoteConfigRepository extends RemoteConfigRepository {
  @override
  Future<void> saveSubscribedVariantsIds(
    Set<KnownVariantId> subscribedVariantIds,
  ) async {
    if (subscribedVariantIds.isEmpty) return;
    final box = await _getBox();
    final json = List<Map<String, dynamic>>.from(
      subscribedVariantIds.map((it) => it.toJson()),
    );
    await box.put(_kExperimentationResultKey, json);
  }

  @override
  Future<Set<KnownVariantId>> readSubscribedVariantIds() async {
    final box = await _getBox();
    if (!box.containsKey(_kExperimentationResultKey)) return <KnownVariantId>{};
    final idSet = await box.get(_kExperimentationResultKey) as List<dynamic>;
    return idSet
        .map(
          (it) => KnownVariantId.fromJson(Map<String, dynamic>.from(it as Map)),
        )
        .toSet();
  }

  @override
  Future<void> saveRemoteConfig(String remoteConfig) async {
    final box = await _getBox();
    await box.put(_kRemoteConfigKey, remoteConfig);
  }

  @override
  Future<String?> readRemoteConfig() async {
    final box = await _getBox();
    if (!box.containsKey(_kRemoteConfigKey)) return null;
    final remoteConfigJson = await box.get(_kRemoteConfigKey);
    return remoteConfigJson as String?;
  }

  Future<LazyBox> _getBox() => Hive.openLazyBox(_kBoxKey);
}
