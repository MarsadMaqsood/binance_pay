import 'dart:convert';

import 'package:binance_pay/binance_pay.dart';
import 'package:http/http.dart' as http;

class BinancePay {
  final String apiKey;
  final String apiSecretKey;

  BinancePay({required this.apiKey, required this.apiSecretKey});

  Future<OrderResponse> createOrder({required RequestBody body}) async {
    // Generate nonce string
    String nonce = generateNonceString();

    // Construct request body
    final requestBody = {
      "env": {
        "terminalType": body.terminalType,
      },
      "merchantTradeNo": body.merchantTradeNo,
      "orderAmount": body.orderAmount,
      "currency": body.currency,
      "goods": {
        "goodsType": body.goodsType,
        "goodsCategory": body.goodsCategory,
        "referenceGoodsId": body.referenceGoodsId,
        "goodsName": body.goodsName,
        "goodsDetail": body.goodsDetail,
      }
    };

    String jsonRequest = json.encode(requestBody);
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    String payload = "$timestamp\n$nonce\n$jsonRequest\n";

    String signature = generateSignature(payload, apiSecretKey).toUpperCase();

    String url = "https://bpay.binanceapi.com/binancepay/openapi/v2/order";

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "BinancePay-Timestamp": timestamp,
      "BinancePay-Nonce": nonce,
      "BinancePay-Certificate-SN": apiKey,
      "BinancePay-Signature": signature
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonRequest,
    );

    final responseBody = jsonDecode(response.body);

    return OrderResponse.fromJson(responseBody);
  }

  Future<QueryResponse> queryOrder(
      {required String prepayId, required String merchantTradeNo}) async {
    // Generate nonce string
    String nonce = generateNonceString();

    // Construct request body
    final requestBody = {
      "merchantTradeNo": merchantTradeNo,
      "prepayId": prepayId,
    };

    String jsonRequest = json.encode(requestBody);
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    String payload = "$timestamp\n$nonce\n$jsonRequest\n";

    String signature = generateSignature(payload, apiSecretKey).toUpperCase();

    String url =
        "https://bpay.binanceapi.com/binancepay/openapi/v2/order/query";

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "BinancePay-Timestamp": timestamp,
      "BinancePay-Nonce": nonce,
      "BinancePay-Certificate-SN": apiKey,
      "BinancePay-Signature": signature
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonRequest,
    );

    final responseBody = jsonDecode(response.body);

    return QueryResponse.fromJson(responseBody);
  }

  Future<CloseResponse> closeOrder(
      {String? prepayId, String? merchantTradeNo}) async {
    if (prepayId == null && merchantTradeNo == null) {
      throw Exception('Both prepayId and merchantTradeNo cannot be null.');
    }

    // Generate nonce string
    String nonce = generateNonceString();

    // Construct request body
    final requestBody = {
      "merchantTradeNo": merchantTradeNo,
      "prepayId": prepayId,
    };

    String jsonRequest = json.encode(requestBody);
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    String payload = "$timestamp\n$nonce\n$jsonRequest\n";

    String signature = generateSignature(payload, apiSecretKey).toUpperCase();

    String url = "https://bpay.binanceapi.com/binancepay/openapi/order/close";

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "BinancePay-Timestamp": timestamp,
      "BinancePay-Nonce": nonce,
      "BinancePay-Certificate-SN": apiKey,
      "BinancePay-Signature": signature
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonRequest,
    );

    final responseBody = jsonDecode(response.body);

    return CloseResponse.fromJson(responseBody);
  }
}
