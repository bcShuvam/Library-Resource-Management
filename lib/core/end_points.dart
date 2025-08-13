class EndPoints{
  // static const String urlShuvam = 'http://182.168.1.4:5005';
  static const String urlShuvam = 'https://f0592e171257.ngrok-free.app';
  // static const String urlShuvam = 'https://100.68.184.237:5005';
  static const String urlMuskan = 'https://f0592e171257.ngrok-free.app';
  static const bool isMuskan = false; // Change to false for Muskan
  static const String baseUrl = isMuskan ? urlMuskan : urlShuvam;

  // General endPoints
  static const String test = '$baseUrl/api/test';

  // Admin Dashboard
  static const String adminDashboard = '$baseUrl/api/admin';

  // Auth endPoints
  static const String auth = '$baseUrl/api/auth/google';

  // Profile endPoints
  static const String profile = '$baseUrl/api/profile';

  // category endPoints
  static const String categories = '$baseUrl/api/category';
  static const String categoriesName = '$baseUrl/api/category/name';

  // catalog endPoints
  static const String catalog = '$baseUrl/api/catalog';

  // borrow endPoints
  static const String borrow = '$baseUrl/api/borrow';
  static const String myBorrow = '$baseUrl/api/borrow/my';
}