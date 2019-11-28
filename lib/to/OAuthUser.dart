class OAuthUser {
  int _id;

  String _userName;

  String _email;

  String _password;

  String _avatarUrl;

  bool _failureCount;

  DateTime _failureTime;

  String _provider;

  DateTime _registered;

  int get id => _id;

  OAuthUser(
      this._id,
      this._userName,
      this._email,
      this._password,
      this._avatarUrl,
      this._failureCount,
      this._failureTime,
      this._provider,
      this._registered);

  set id(int value) {
    _id = value;
  }

  String get userName => _userName;

  DateTime get registered => _registered;

  set registered(DateTime value) {
    _registered = value;
  }

  String get provider => _provider;

  set provider(String value) {
    _provider = value;
  }

  DateTime get failureTime => _failureTime;

  set failureTime(DateTime value) {
    _failureTime = value;
  }

  bool get failureCount => _failureCount;

  set failureCount(bool value) {
    _failureCount = value;
  }

  String get avatarUrl => _avatarUrl;

  set avatarUrl(String value) {
    _avatarUrl = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  set userName(String value) {
    _userName = value;
  }

  factory OAuthUser.fromJSON(Map<String, dynamic> json) {
    return OAuthUser(
      json['id'],
      json['user_name'],
      json['email'],
      json['password'],
      json['avatar_url'],
      json['failure_count'],
      json['failure_time'],
      json['provider'],
      DateTime.parse(json['registered']),
    );
  }

  @override
  String toString() {
    return 'OAuthUser{_id: $_id, _userName: $_userName, _email: $_email, _password: $_password, _avatarUrl: $_avatarUrl, _failureCount: $_failureCount, _failureTime: $_failureTime, _provider: $_provider, _registered: $_registered}';
  }
}
