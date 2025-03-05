import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class TheMovieDbApiClient {
  static Future<http.Client> get getHttpClient async {
    final sslCert =
        await rootBundle.load('assets/certificates/api.themoviedb.org.crt');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    final ioClient = HttpClient(context: securityContext);
    ioClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    return IOClient(ioClient);
  }
}
