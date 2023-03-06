class AddStoriesResponse {
  bool error;
  String message;

  AddStoriesResponse({required this.error, required this.message});

  factory AddStoriesResponse.fromJson(Map<String, dynamic> json) =>
      AddStoriesResponse(
        error: json['error'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
      };
}
