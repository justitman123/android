class ApiResponse {
  String _accessToken;
  String _tokenType;

  ApiResponse(this._accessToken, this._tokenType);

  String get getAccessToken => _accessToken;

  set setAccessToken(String value) {
    _accessToken = value;
  }

  String get getTokenType => _tokenType;

  set setTokenType(String value) {
    _tokenType = value;
  }

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _itemFromJson(json);
}

ApiResponse _itemFromJson(Map<String, dynamic> json) {
  return ApiResponse(
      json['accessToken'] as String, json['tokenType'] as String);
}
