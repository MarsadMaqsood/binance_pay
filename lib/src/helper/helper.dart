import 'dart:convert';

import 'package:crypto/crypto.dart';

String generateNonceString() {
  String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String nonce = '';
  for (int i = 1; i <= 32; i++) {
    int pos = DateTime.now().microsecondsSinceEpoch % chars.length;
    String char = chars[pos];
    nonce += char;
  }
  return nonce;
}

String generateMerchantTradeNo() {
  int min = 982538;
  int max = 9825382937292;
  return (min + DateTime.now().microsecondsSinceEpoch % (max - min)).toString();
}

String generateSignature(String payload, String secretKey) {
  List<int> key = utf8.encode(secretKey);
  List<int> bytes = utf8.encode(payload);
  Hmac hmac = Hmac(sha512, key);
  Digest digest = hmac.convert(bytes);
  return digest.toString();
}
