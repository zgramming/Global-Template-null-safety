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
  String? urlLogoAsset;

  /// LexendDeca
  String? headerFont;

  /// Poppins
  String? defaultFont;

  /// https://homepages.cae.wisc.edu/~ece533/images/airplane.png
  String? defaultImageNetwork;

  /// {'Content-Type': 'application/x-www-form-urlencoded'}
  Map<String, String>? headersAPI;

  AppConfig({
    this.indonesiaLocale = 'id_ID',
    this.urlAPK,
    this.baseAPIURL,
    this.baseImageURL,
    this.tokenFirebase,
    this.urlImageAsset,
    this.urlLogoAsset,
    this.headerFont,
    this.defaultFont,
    this.defaultImageNetwork,
    this.headersAPI,
  });

  void configuration({
    /// asset/images
    String? urlImageAsset,

    /// http://www.example/apk/apk.apk
    String? urlAPK,

    /// logo.png
    String? urlLogoAsset,

    /// http://www.example.com
    String? baseAPIURL,

    /// http://www.example.com/images
    String? baseImageURL,

    /// exampletoken
    String? tokenFirebase,

    /// LexendDeca
    String? headerFont,

    /// Poppins
    String? defaultFont,

    /// https://homepages.cae.wisc.edu/~ece533/images/airplane.png
    String? defaultImageNetwork,

    /// {'Content-Type': 'application/x-www-form-urlencoded'}
    Map<String, String>? headersAPI,
  }) {
    this.urlAPK = urlAPK ?? 'https://www.example.com/apk/apk.apk';
    this.headerFont = headerFont ?? 'LexendDeca';
    this.defaultFont = defaultFont ?? 'Poppins';
    this.defaultImageNetwork =
        defaultImageNetwork ?? 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png';
    this.urlImageAsset = urlImageAsset ?? 'assets/images';
    this.urlLogoAsset = urlLogoAsset ?? 'logo_transparent.png';
    this.baseAPIURL = baseAPIURL ?? 'https://www.example.com';
    this.baseImageURL = baseImageURL ?? 'https://www.example.com/images';
    this.tokenFirebase = tokenFirebase ?? 'exampletoken';
    this.headersAPI = headersAPI ?? {'Content-Type': 'application/x-www-form-urlencoded'};
  }
}

final appConfig = AppConfig();
