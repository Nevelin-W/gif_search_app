import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});
