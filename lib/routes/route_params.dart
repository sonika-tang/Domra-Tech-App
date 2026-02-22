/// Route parameters - Keys for passing arguments between screens
class RouteParams {
  RouteParams._(); // Prevent instantiation

  // 
  // WordTranslation Parameters
  // 
  static const String wordId = 'wordId';
  static const String englishWord = 'englishWord';
  static const String khmerWord = 'khmerWord';
  static const String frenchWord = 'frenchWord';
  static const String normalizedWord = 'normalizedWord';
  static const String definition = 'definition';
  static const String example = 'example';
  static const String imageURL = 'imageURL';
  static const String reference = 'reference';
  static const String referenceText = 'referenceText';

  // 
  // Category Parameters
  // 
  static const String categoryId = 'categoryId';
  static const String categoryName = 'categoryName';
  static const String description = 'description';

  // 
  // WordCategory Parameters
  // 
  // Uses wordId + categoryId (composite key)

  // 
  // Search Parameters
  // 
  static const String searchQuery = 'searchQuery';
  static const String selectedCategory = 'selectedCategory';

  // 
  // WordRequest Parameters
  // 
  static const String wordRequestId = 'wordRequestId';
  static const String newEnglishWord = 'newEnglishWord';
  static const String newKhmerWord = 'newKhmerWord';
  static const String newFrenchWord = 'newFrenchWord';
  static const String newDefinition = 'newDefinition';
  static const String newExample = 'newExample';
  static const String wordRequestStatus = 'wordRequestStatus';
  static const String wordRequestCheck = 'wordRequestCheck';

  // 
  // CorrectionRequest Parameters
  // 
  static const String correctionId = 'correctionId';
  static const String correctionWordId = 'correctionWordId';
  static const String correctEnglishWord = 'correctEnglishWord';
  static const String correctKhmerWord = 'correctKhmerWord';
  static const String correctFrenchWord = 'correctFrenchWord';
  static const String correctionStatus = 'correctionStatus';

  // 
  // Favorite Parameters (userId + wordId composite)
  // 
  static const String favoriteWordId = 'favoriteWordId';
  static const String favoriteUserId = 'favoriteUserId';

  // 
  // PaymentModel Parameters
  // 
  static const String paymentId = 'paymentId';
  static const String planId = 'planId';
  static const String planName = 'planName';
  static const String planPrice = 'planPrice';
  static const String qrString = 'qrString';
  static const String md5Hash = 'md5Hash';
  static const String paymentStatus = 'paymentStatus';
  static const String paymentAmount = 'paymentAmount';
  static const String billNumber = 'billNumber';

  // 
  // User Parameters
  // 
  static const String userId = 'userId';
  static const String googleId = 'googleId';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String email = 'email';
  static const String profileURL = 'profileURL';
  static const String userRole = 'userRole';
  static const String userStatus = 'userStatus';

  // 
  // Navigation Parameters
  // 
  static const String previousRoute = 'previousRoute';
  static const String isDeepLink = 'isDeepLink';
  static const String token = 'token';
  static const String contributionType =
      'contributionType'; // 'word_request' or 'correction'
}

