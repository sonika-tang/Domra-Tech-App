class User {
  final int userId;
  final String? googleId;
  final String? profileURL;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? role;
  final String? status;

  User({
    required this.userId,
    this.googleId,
    this.profileURL,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      googleId: json['googleId'],
      profileURL: json['profileURL'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      role: json['role'],
      status: json['status'],
    );
  }
}
