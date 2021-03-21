class AppConfig {
  /// id
  String indonesiaLocale;

  ///
  String? urlAPK;

  /// http://www.example.com
  String? baseAPIURL;

  /// http://www.example.com/images
  String? baseImageURL;

  /// exampletoken
  String? tokenFirebase;

  /// asset/images
  String? urlImageAsset;

  /// logo.png
  String? nameLogoAsset;

  /// https://homepages.cae.wisc.edu/~ece533/images/airplane.png
  String? defaultImageNetwork;

  /// {'Content-Type': 'application/x-www-form-urlencoded'}
  Map<String, String>? headersAPI;

  AppConfig({
    this.indonesiaLocale = 'id_ID',
    this.urlAPK = 'https://www.example.com/apk/apk.apk',
    this.defaultImageNetwork = 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
    this.urlImageAsset = 'assets/images',
    this.nameLogoAsset = 'logo_transparent.png',
    this.baseAPIURL = 'https://www.example.com',
    this.baseImageURL = 'https://www.example.com/images',
    this.tokenFirebase = 'exampletoken',
    this.headersAPI = const {'Content-Type': 'application/x-www-form-urlencoded'},
  });

  void configuration({
    /// asset/images
    String urlImageAsset = 'assets/images',

    /// http://www.example/apk/apk.apk
    String urlAPK = 'https://www.example.com/apk/apk.apk',

    /// logo.png
    String nameLogoAsset = 'logo_transparent.png',

    /// http://www.example.com
    String baseAPIURL = 'https://www.example.com',

    /// http://www.example.com/images
    String baseImageURL = 'https://www.example.com/images',

    /// exampletoken
    String tokenFirebase = 'exampletoken',

    /// https://homepages.cae.wisc.edu/~ece533/images/airplane.png
    String defaultImageNetwork = 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',

    /// {'Content-Type': 'application/x-www-form-urlencoded'}
    Map<String, String>? headersAPI,
  }) {
    this.urlAPK = urlAPK;
    this.defaultImageNetwork = defaultImageNetwork;
    this.urlImageAsset = urlImageAsset;
    this.nameLogoAsset = nameLogoAsset;
    this.baseAPIURL = baseAPIURL;
    this.baseImageURL = baseImageURL;
    this.tokenFirebase = tokenFirebase;
    this.headersAPI = headersAPI;
  }
}

final appConfig = AppConfig();
