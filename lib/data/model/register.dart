class RegisterInputModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  RegisterInputModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'password': password,
  };
}
