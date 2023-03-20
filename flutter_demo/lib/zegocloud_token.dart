import 'dart:convert';
import 'dart:core';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;

class ZegoTokenUtils {
  static String generateToken(int appid, String serverSecret, String userID,
      {int effectiveTimeInSeconds = 60 * 60 * 24, String payload = ''}) {
    if (appid == 0) {
      throw Exception('appid Invalid');
    }
    if (userID == '') {
      throw Exception('userID Invalid');
    }
    if (serverSecret.length != 32) {
      throw Exception('serverSecret Invalid');
    }
    if (effectiveTimeInSeconds <= 0) {
      throw Exception('effectiveTimeInSeconds Invalid');
    }
    final tokenInfo = TokenInfo04(
      appid: appid,
      userID: userID,
      nonce: math.Random().nextInt(math.pow(2, 31).toInt()),
      ctime: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      expire: 0,
      payload: payload,
    );
    tokenInfo.expire = tokenInfo.ctime + effectiveTimeInSeconds;
    // Convert token information to json
    final tokenJson = tokenInfo.toJson();

    // Randomly generated 16-byte string, used as AES encryption vector,
    // before the ciphertext for Base64 encoding to generate the final token
    final ivStr = createRandomString(16);
    final iv = encrypt.IV.fromUtf8(ivStr);

    final key = encrypt.Key.fromUtf8(serverSecret);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(tokenJson, iv: iv);

    final bytes1 = createUint8ListFromInt(tokenInfo.expire);
    final bytes2 = Uint8List.fromList([0, 16]);
    final bytes3 = Uint8List.fromList(utf8.encode(ivStr));
    final bytes4 = Uint8List.fromList([0, encrypted.bytes.length]);
    final bytes5 = encrypted.bytes;

    final bytes = Uint8List(4) + bytes1 + bytes2 + bytes3 + bytes4 + bytes5;
    final ret = '04${base64.encode(bytes)}';
    return ret;
  }

  static final _random = math.Random();
  static const _defaultPool = 'ModuleSymbhasOwnPr-0123456789ABCDEFGHNRVfgctiUvz_KqYTJkLxpZXIjQW';

  static String createRandomString(int size, {String pool = _defaultPool}) {
    final len = pool.length;
    var id = '';
    var i = size;
    while (0 < i--) {
      id += pool[_random.nextInt(len)];
    }
    return id;
  }

  /// Creates a `Uint8List` by a hex string.
  static Uint8List createUint8ListFromHexString(String hex) {
    final result = Uint8List(hex.length ~/ 2);
    for (var i = 0; i < hex.length; i += 2) {
      final num = hex.substring(i, i + 2);
      final byte = int.parse(num, radix: 16);
      result[i ~/ 2] = byte;
    }

    return result;
  }

  /// Returns a hex string by a `Uint8List`.
  static String formatBytesAsHexString(Uint8List bytes) {
    final result = StringBuffer();
    for (var i = 0; i < bytes.lengthInBytes; i++) {
      final part = bytes[i];
      result.write('${part < 16 ? '0' : ''}${part.toRadixString(16)}');
    }

    return result.toString();
  }

  static Uint8List createUint8ListFromInt(int hex) {
    return createUint8ListFromHexString(hex.toRadixString(16));
  }
}

class TokenInfo04 {
  TokenInfo04(
      {required this.appid,
      required this.userID,
      required this.ctime,
      required this.expire,
      required this.nonce,
      required this.payload});
  int appid;
  String userID;
  int nonce;
  int ctime;
  int expire;
  String payload;

  String toJson() {
    return '{"app_id":$appid,"user_id":"$userID","nonce":$nonce,"ctime":$ctime,"expire":$expire,"payload":"$payload"}';
  }
}
