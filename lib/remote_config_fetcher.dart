import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aws_s3_api/s3-2006-03-01.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:dart_remote_config/model/remote_config_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_aws_api/shared.dart';
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

typedef S3Factory = S3 Function();
typedef RConfigFileNameBuilder = String Function();

RConfigFileNameBuilder defaultNameBuilder({
  required String appId,
  String flavor = '',
  String filePostfix = '_rconfig.yaml',
}) =>
    () =>
        "${appId.replaceAll('.', '_')}${flavor.isNotEmpty ? '_${flavor.toLowerCase()}' : ''}$filePostfix";

S3Factory defaultS3Factory({
  required String s3Region,
  required String endpointUrl,
  required String accessKey,
  required String secretKey,
}) =>
    () => S3(
          region: s3Region,
          endpointUrl: endpointUrl,
          credentials: AwsClientCredentials(
            accessKey: accessKey,
            secretKey: secretKey,
          ),
        );

class S3RemoteConfigFetcher extends RemoteConfigFetcher
    with RemoteConfigFetcherBase {
  final S3Factory s3Factory;
  final RConfigFileNameBuilder nameBuilder;
  final String bucketName;
  final RemoteConfigParser parser;

  S3RemoteConfigFetcher({
    required this.s3Factory,
    required this.nameBuilder,
    required this.bucketName,
    this.parser = const RemoteConfigParser(),
  });

  @override
  Future<RemoteConfigResponse> fetch() async {
    final s3 = s3Factory();
    try {
      final listBucketsOutput = await s3.getObject(
        bucket: bucketName,
        key: nameBuilder(),
      );

      final content =
          utf8.decode(Uint8List.fromList(listBucketsOutput.body ?? []));
      return fromYamlStringContent(content, parser);
    } on GenericAwsException catch (e) {
      return RemoteConfigResponse.failure(
        error: RemoteConfigResponseError.errorNoDataFetched,
        message: e.code,
      );
    }
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
