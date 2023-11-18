class NetworkException {
  final int statusCode;
  final String message;

  NetworkException({
    required this.statusCode,
    required this.message,
  });

  factory NetworkException.fromJson(Map<String, dynamic> json) =>
      NetworkException(
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
      };
}
