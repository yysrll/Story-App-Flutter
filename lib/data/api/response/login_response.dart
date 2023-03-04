class LoginResponse {
  bool? error;
  String? message;
  LoginResultResponse? loginResult;

  LoginResponse({this.error, this.message, this.loginResult});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    loginResult = json['loginResult'] != null
        ? LoginResultResponse.fromJson(json['loginResult'])
        : null;
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'loginResult': loginResult?.toJson()
      };
}

class LoginResultResponse {
  String? userId;
  String? name;
  String? token;

  LoginResultResponse({this.userId, this.name, this.token});

  LoginResultResponse.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'token': token,
      };
}
