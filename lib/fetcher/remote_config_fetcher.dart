import 'dart:io';

import 'package:dart_remote_config/model/remote_config.dart';
import 'package:dart_remote_config/model/remote_config_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yaml/yaml.dart';

abstract class RemoteConfigFetcher {
  Future<RemoteConfigResponse> fetch();
}

class FileRemoteConfigFetcher extends RemoteConfigFetcher
    with RemoteConfigFetcherBase {
  final String filePath;
  final RemoteConfigParser parser;

  FileRemoteConfigFetcher(
    this.filePath, {
    this.parser = const RemoteConfigParser(),
  });

  @override
  Future<RemoteConfigResponse> fetch() async {
    final content = await File(filePath).readAsString();
    return fromYamlStringContent(content, parser);
  }
}

class StringRemoteConfigFetcher
    with RemoteConfigFetcherBase
    implements RemoteConfigFetcher {
  final RemoteConfigParser parser = const RemoteConfigParser();
  final String input;

  StringRemoteConfigFetcher(this.input);

  @override
  Future<RemoteConfigResponse> fetch() async {
    return fromYamlStringContent(input, parser);
  }
}

mixin RemoteConfigFetcherBase {
  @protected
  RemoteConfigResponse fromYamlStringContent(
    String content,
    RemoteConfigParser parser,
  ) {
    if (content.isNotEmpty) {
      try {
        final config = parser.parse(content);
        return RemoteConfigResponse.success(config);
      } catch (e) {
        return RemoteConfigResponse.failure(
          error: RemoteConfigResponseError.errorWhileParsing,
          message: e.toString(),
        );
      }
    } else {
      return const RemoteConfigResponse.failure(
        error: RemoteConfigResponseError.errorNoData,
      );
    }
  }
}

class RemoteConfigParser {
  const RemoteConfigParser();

  RemoteConfigs parse(String content) =>
      RemoteConfigs.fromJson(loadYaml(content));
}
