import 'dart:io';

import 'package:core/common/utils.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class TheMovieDbApiClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final ioClient = HttpClient(context: await tmdbSecurityContext);
    ioClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    final client = IOClient(ioClient);
    return client.send(request);
  }
}
