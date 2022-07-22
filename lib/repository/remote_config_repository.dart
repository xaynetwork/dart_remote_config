import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:hive/hive.dart';
import 'package:tuple/tuple.dart';

const _kBoxKey = 'RemoteConfigBox';
const _kExperimentationResultKey = 'ExperimentationResult';

abstract class RemoteConfigRepository {
  Future<void> saveSubscribedVariantsIds(
    Set<ExperimentIdAndVariantId> subscribedVariantIds,
  );

  Future<Set<ExperimentIdAndVariantId>> readSubscribedVariantIds();
}

class RemoteConfigRepositoryImpl extends RemoteConfigRepository {
  @override
  Future<void> saveSubscribedVariantsIds(
    Set<ExperimentIdAndVariantId> subscribedVariantIds,
  ) async {
    if (subscribedVariantIds.isEmpty) return;
    final box = await _getBox();
    await box.putAt(0, subscribedVariantIds.map((it) => it.toList()));
  }

  @override
  Future<Set<ExperimentIdAndVariantId>> readSubscribedVariantIds() async {
    final box = await _getBox();
    final idSet =
        await box.get(_kExperimentationResultKey) as Iterable<List<dynamic>>;
    return idSet
        .map((it) => Tuple2.fromList(it) as ExperimentIdAndVariantId)
        .toSet();
  }

  Future<LazyBox> _getBox() => Hive.openLazyBox(_kBoxKey);
}
