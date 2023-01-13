class Environments {
  static const String PRODUCTION = 'prod';
  static const String DEV = 'dev';
}

class ConfigEnvironments {
  static const String currentEnvironments = Environments.DEV;
  static const String apiKey = '9f50b5f1e9294699a2e52500682ea6a4';
  static const int perPage = 10;

  static final List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.DEV,
      'url': 'https://newsapi.org/',
    },
    {
      'env': Environments.PRODUCTION,
      'url': '',
    },
  ];

  static Map<String, String> getEnvironments() {
    return _availableEnvironments.firstWhere(
      (d) => d['env'] == currentEnvironments,
      orElse: () => _availableEnvironments[1],
    );
  }
}
