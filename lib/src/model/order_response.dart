class OrderResponse {
  final String status;
  final String code;
  final OrderResponseData? data;
  final String? errorMessage;

  OrderResponse(this.status, this.code, this.data, this.errorMessage);

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      json['status'],
      json['code'],
      json['data'] != null ? OrderResponseData.fromJson(json['data']) : null,
      json['errorMessage'],
    );
  }
}

class OrderResponseData {
  final String prepayId;
  final String terminalType;
  final int expireTime;
  final String qrcodeLink;
  final String qrContent;
  final String checkoutUrl;
  final String deeplink;
  final String universalUrl;
  final String currency;
  final double totalFee;

  OrderResponseData(
    this.prepayId,
    this.terminalType,
    this.expireTime,
    this.qrcodeLink,
    this.qrContent,
    this.checkoutUrl,
    this.deeplink,
    this.universalUrl,
    this.currency,
    this.totalFee,
  );

  factory OrderResponseData.fromJson(Map<String, dynamic> json) {
    return OrderResponseData(
      json['prepayId'],
      json['terminalType'],
      json['expireTime'],
      json['qrcodeLink'],
      json['qrContent'],
      json['checkoutUrl'],
      json['deeplink'],
      json['universalUrl'],
      json['currency'],
      json['totalFee'],
    );
  }
}
