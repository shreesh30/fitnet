import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

// TwitterApi class adapted from DanTup:
// https://blog.dantup.com/2017/01/simplest-dart-code-to-post-a-tweet-using-oauth/
class FatSecretApi {

  final String fatSecretApiBaseUrl = "platform.fatsecret.com";

  bool isJson = true;

  final String consumerKey, consumerKeySecret, accessToken, accessTokenSecret;

  Hmac _sigHasher;

  FatSecretApi(this.consumerKey, this.consumerKeySecret, this.accessToken,
      this.accessTokenSecret) {
    var bytes = utf8.encode("$consumerKeySecret&$accessTokenSecret");
    _sigHasher = new Hmac(sha1, bytes);
  }

  FatSecretApi forceXml() {
    this.isJson = false;
    return this;
  }

  /// Sends a tweet with the supplied text and returns the response from the Twitter API.
  Future<http.Response> request(Map<String, String> data) {
    if (isJson) {
      data["format"] = "json";
    }
    return _callGetApi("rest/server.api", data);
  }

  Future<http.Response> _callGetApi(String url, Map<String, String> data) {
    Uri requestUrl = Uri.https(fatSecretApiBaseUrl, url);

    print(data["method"]);
    _setAuthParams("GET", requestUrl.toString(), data);

    requestUrl = Uri.https(requestUrl.authority, requestUrl.path, data);

    String oAuthHeader = _generateOAuthHeader(data);

    // Build the OAuth HTTP Header from the data.
    // Build the form data (exclude OAuth stuff that's already in the header).
//    var formData = _filterMap(data, (k) => !k.startsWith("oauth_"));
    return _sendGetRequest(requestUrl, oAuthHeader);
  }

  void _setAuthParams(String requestMethod, String url, Map<String, String> data) {

    // Timestamps are in seconds since 1/1/1970.
    // var timestamp = new DateTime.now().toUtc().difference(_epochUtc).inSeconds;
    var millisecondsSinceEpoch = new DateTime.now().toUtc().millisecondsSinceEpoch;
    var timestamp = (millisecondsSinceEpoch  / 100).round();

    // Add all the OAuth headers we'll need to use when constructing the hash.
    data["oauth_consumer_key"] = consumerKey;
    data["oauth_signature_method"] = "HMAC-SHA1";
    data["oauth_timestamp"] = timestamp.toString();
    data["oauth_nonce"] = _randomString(8); // Required, but Twitter doesn't appear to use it
    if (accessToken != null && accessToken.isNotEmpty) data["oauth_token"] = accessToken;
    data["oauth_version"] = "1.0";

    // Generate the OAuth signature and add it to our payload.
    data["oauth_signature"] = _generateSignature(requestMethod, Uri.parse(url), data);
  }

  /// Generate an OAuth signature from OAuth header values.
  String _generateSignature(String requestMethod, Uri url, Map<String, String> data) {
    var sigString = _toQueryString(data);
    var fullSigData = "$requestMethod&${_encode(url.toString())}&${_encode(sigString)}";

    return base64.encode(_hash(fullSigData));
  }

  /// Generate the raw OAuth HTML header from the values (including signature).
  String _generateOAuthHeader(Map<String, String> data) {
    var oauthHeaderValues = _filterMap(data, (k) => k.startsWith("oauth_"));

    return "OAuth " + _toOAuthHeader(oauthHeaderValues);
  }

  /// Send HTTP Request and return the response.
  Future<http.Response> _sendGetRequest(Uri fullUrl, String oAuthHeader) async {
    return await http.get(fullUrl, headers: { });
  }

  Map<String, String> _filterMap(
      Map<String, String> map, bool test(String key)) {
    return new Map.fromIterable(map.keys.where(test), value: (k) => map[k]);
  }

  String _toQueryString(Map<String, String> data) {
    var items = data.keys.map((k) => "$k=${_encode(data[k])}").toList();
    items.sort();

    return items.join("&");
  }

  String _toOAuthHeader(Map<String, String> data) {
    var items = data.keys.map((k) => "$k=\"${_encode(data[k])}\"").toList();
    items.sort();

    return items.join(", ");
  }

  List<int> _hash(String data) => _sigHasher.convert(data.codeUnits).bytes;

  String _encode(String data) => percent.encode(data.codeUnits);

  String _randomString(int length) {
    var rand = new Random();
    var codeUnits = new List.generate(
        length,
            (index){
          return rand.nextInt(26)+97;
        }
    );

    return new String.fromCharCodes(codeUnits);
  }
}
