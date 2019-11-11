class ApiResponse {
  final String accessToken;
  final String tokenType;
  ApiResponse(
      {this.accessToken,
        this.tokenType});
  factory ApiResponse.fromJson(Map<String, dynamic> json) => _itemFromJson(json);
}

ApiResponse _itemFromJson(Map<String, dynamic> json) {
  return ApiResponse(
      accessToken: json['accessToken'] as String,
      tokenType: json['tokenType'] as String);
}