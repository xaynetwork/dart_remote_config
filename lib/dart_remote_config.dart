import 'package:dart_remote_config/experimentation/experimentation_engine.dart';
import 'package:dart_remote_config/experimentation/experimentation_module.dart';
import 'package:dart_remote_config/fetcher/remote_config_fetcher.dart';
import 'package:dart_remote_config/model/dart_remote_config_state.dart';
import 'package:dart_remote_config/repository/remote_config_repository.dart';
import 'package:pub_semver/pub_semver.dart';

export 'fetcher/cache_strategy.dart';
export 'fetcher/remote_config_fetcher.dart';
export 'fetcher/s3_remote_config_fetcher.dart';
export 'model/promo_code.dart';
export 'model/remote_config.dart';
export 'model/remote_config_response.dart';
export 'utils/extensions.dart';

typedef VersionProvider = String Function();
typedef ExperimentationModuleFactory = ExperimentationModule Function(
    Version appVersion);

class DartRemoteConfig {
  final RemoteConfigFetcher _fetcher;
  final VersionProvider _versionProvider;
  final ExperimentationModuleFactory _experimentationModuleFactory;

  static ExperimentationModule _initExperimentationModule(Version appVersion) =>
      ExperimentationModule(
        ExperimentationEngineImpl(appVersion),
        HiveRemoteConfigRepository(),
      );

  DartRemoteConfig({
    required RemoteConfigFetcher fetcher,
    required VersionProvider versionProvider,
    ExperimentationModuleFactory? experimentationModuleFactory,
  })  : _fetcher = fetcher,
        _versionProvider = versionProvider,
        _experimentationModuleFactory =
            experimentationModuleFactory ?? _initExperimentationModule;

  Future<DartRemoteConfigState> create() async {
    final configRes = await _fetcher.fetch();

    return await configRes.map(
      success: (r) async {
        final version = Version.parse(_versionProvider());
        final config = r.remoteConfigs.findConfig(version);
        final experimentationModule = _experimentationModuleFactory(version);
        if (config == null) {
          return const DartRemoteConfigState.failed(
              status: DartRemoteConfigStatus.noSuitableVersion);
        }

        final experiments = await experimentationModule.compute(config);

        return DartRemoteConfigState.success(
          config: config,
          experiments: experiments,
        );
      },
      failure: (e) {
        return DartRemoteConfigState.failed(
          status: DartRemoteConfigStatus.failedFetching,
          fetcherError: e,
        );
      },
    );
  }
}
