import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  String get apiBaseUrl {
    return dotenv.env['ENDPOINT_URL']!;
  }
}