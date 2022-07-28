import 'package:dart_remote_config/model/known_experiment_variant.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:hive/hive.dart';

const _kBoxKey = 'RemoteConfigBox';
const _kExperimentationResultKey = 'ExperimentationResult';
const _kRemoteConfigKey = 'RemoteConfig';

abstract class RemoteConfigRepository {
  Future<void> saveSubscribedVariantsIds(
    Set<KnownVariantId> subscribedVariantIds,
  );

  Future<Set<KnownVariantId>> readSubscribedVariantIds();

  Future<void> saveRemoteConfig(RemoteConfig remoteConfig);

  Future<RemoteConfig?> readRemoteConfig();
}

class RemoteConfigRepositoryImpl extends RemoteConfigRepository {
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

  @override
  Future<void> saveRemoteConfig(RemoteConfig remoteConfig) async {
    final box = await _getBox();
    await box.put(_kRemoteConfigKey, remoteConfig.toJson());
  }

  @override
  Future<RemoteConfig?> readRemoteConfig() async {
    final box = await _getBox();
    if (!box.containsKey(_kRemoteConfigKey)) return null;
    final remoteConfigJson =
        await box.get(_kRemoteConfigKey) as Map<String, dynamic>;
    return RemoteConfig.fromJson(remoteConfigJson);
  }

  Future<LazyBox> _getBox() => Hive.openLazyBox(_kBoxKey);
}
