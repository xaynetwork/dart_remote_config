import 'dart:convert';
import 'dart:typed_data';

import 'package:aws_s3_api/s3-2006-03-01.dart';
import 'package:dart_remote_config/fetcher/remote_config_fetcher.dart';
import 'package:dart_remote_config/model/remote_config_response.dart';
import 'package:shared_aws_api/shared.dart';

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
  final CacheStrategy cacheStrategy;

  S3RemoteConfigFetcher({
    required this.s3Factory,
    required this.nameBuilder,
    required this.bucketName,
    this.cacheStrategy = const NoCachingStrategy(),
    this.parser = const RemoteConfigParser(),
  });

  @override
  Future<RemoteConfigResponse> fetch() async {
    try {
      final content = await cacheStrategy.fetch(_fetchContentFromS3);
      return fromYamlStringContent(content, parser);
    } on GenericAwsException catch (e) {
      return RemoteConfigResponse.failure(
        error: RemoteConfigResponseError.errorNoDataFetched,
        message: e.code,
      );
    }
  }

  Future<String> _fetchContentFromS3() async {
    final s3 = s3Factory();
    final listBucketsOutput = await s3.getObject(
      bucket: bucketName,
      key: nameBuilder(),
    );

    return utf8.decode(Uint8List.fromList(listBucketsOutput.body ?? []));
  }
}

class NoCachingStrategy extends CacheStrategy {
  const NoCachingStrategy();

  @override
  Future<String> fetch(Future<String> Function() request) => request();
}

abstract class CacheStrategy {
  const CacheStrategy();

  Future<String> fetch(Future<String> Function() request);
}
