import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {
  final JsonDecoder _decoder = new JsonDecoder();
  final JsonEncoder _encoder = new JsonEncoder();

  Map<String, String> headers = {"content-type": "application/json"};
  Map<String, String> cookies = {};

  void _updateCookie(http.Response response) {
    String allSetCookie = response.headers['set-cookie'];

    if (allSetCookie != null) {
      var setCookies = allSetCookie.split(',');

      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');

        for (var cookie in cookies) {
          _setCookie(cookie);
        }
      }

      headers['cookie'] = _generateCookieHeader();
    }
  }

  void _setCookie(String rawCookie) {
    if (rawCookie.length > 0) {
      var keyValue = rawCookie
          .split('=')
          .where((s) => s.isNotEmpty)
          .toList(growable: false);
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];

        this.cookies[key] = value;
      }
    }
  }

  String _generateCookieHeader() {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.length > 0) cookie += ";";
      cookie += key + "=" + cookies[key];
    }

    return cookie;
  }

  Future<dynamic> get(String url) {
    return http.get(url, headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      _updateCookie(response);

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, {body, encoding}) {
    return http
        .post(url,
            body: _encoder.convert(body), headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      _updateCookie(response);

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<String> loginPost(String url, {body, encoding}) {
    return http
        .post(url,
            body: json.encode(body), headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      print(res);
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      var post = Post.fromJson(json.decode(res));
      print("accessToken=" + post.accessToken);

      String allSetCookie = "accessToken=" + post.accessToken;

      if (allSetCookie != null) {
        var setCookies = allSetCookie.split(',');

        for (var setCookie in setCookies) {
          var cookies = setCookie.split(';');

          for (var cookie in cookies) {
            _setCookie(cookie);
          }
        }

        headers['cookie'] = _generateCookieHeader();
      }
      return;
    });
  }
}

class Post {
  final String accessToken;
  final String tokenType;

  Post({this.accessToken, this.tokenType});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      accessToken: json['accessToken'],
      tokenType: json['tokenType'],
    );
  }
}
