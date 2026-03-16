class User {
  final int userId;
  final String? googleId;
  final String? profileURL;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? role;
  final String? status;
  final String? gender;
  final String? dateOfBirth;

  User({
    required this.userId,
    this.googleId,
    this.profileURL,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.status,
    this.gender,
    this.dateOfBirth,
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
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
    );
  }
}
