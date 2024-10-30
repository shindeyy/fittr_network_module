import 'package:fittr_network_module/src/api/env_constants.dart';

class Endpoints {
  static const String baseUrlSit2 = 'https://api-ms-sit3.fittr.com';
  static const String baseUrlSit3 = 'https://www.moduletwo.com';
  static const String baseUrlSit4 = 'https://api-ms-sit4.fittr.com';
  static const String baseUrlProd = 'https://www.productionmodule.com';

  static String getBaseUrl(String environment) {
    switch (environment) {
      case AppEnvironments.sit2:
        return baseUrlSit2;
      case AppEnvironments.sit3:
        return baseUrlSit3;
      case AppEnvironments.sit4:
        return baseUrlSit4;
      default:
        return baseUrlProd;
    }
  }

  static String getDietToolBaseUrl(String environment) {
    switch (environment) {
      case AppEnvironments.sit2:
        return baseUrlSit2;
      case AppEnvironments.sit3:
        return baseUrlSit3;
      case AppEnvironments.sit4:
        return baseUrlSit4;
      default:
        return baseUrlProd;
    }
  }
}