import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<void> clearCache() async {
  await DefaultCacheManager().emptyCache();
}

Future<void> getCachedFile(
    {String? cacheKey,
    required String url,
    void Function(String cacheKey, double? progress, int downloaded)?
        onProgress,
    required void Function(String cacheKey, FileInfo fileInfo)
        onCompleted}) async {
  cacheKey ??= url;
  final fileResponse = DefaultCacheManager()
      .getFileStream(url, key: cacheKey, withProgress: true);
  fileResponse.listen((event) {
    if (event is DownloadProgress) {
      if (onProgress != null) {
        onProgress(
            cacheKey!,
            event.totalSize != null
                ? event.downloaded / event.totalSize!
                : null,
            event.downloaded);
      }
    } else {
      onCompleted(cacheKey!, event as FileInfo);
    }
  });
}
