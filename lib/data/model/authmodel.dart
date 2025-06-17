class AuthModel {
  final String? message;
  final String? token;
  

  AuthModel({this.message,this.token});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      message: json['message'],
      token: json['token'],
    );
  }
}