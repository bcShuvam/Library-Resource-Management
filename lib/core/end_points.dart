class EndPoints{
  static const String urlShuvam = 'http://192.168.1.2:5005/api';
  static const String urlMuskan = 'http://localhost:5005/api';
  static const bool isMuskan = false; // Change to false for Muskan
  static const String baseUrl = isMuskan ? urlMuskan : urlShuvam;

  // Auth endPoints
  static const String auth = '$baseUrl/auth/google';

  // category endPoints
  static const String categories = '$baseUrl/category';

  // catalog endPoints
  static const String catalog = '$baseUrl/catalog';
}