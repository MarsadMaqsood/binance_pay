class OrderResponse {
  String status;
  String code;
  OrderResponseData? data;
  String? errorMessage;

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
  String prepayId;
  String terminalType;
  int expireTime;
  String qrcodeLink;
  String qrContent;
  String checkoutUrl;
  String deeplink;
  String universalUrl;

  OrderResponseData(
    this.prepayId,
    this.terminalType,
    this.expireTime,
    this.qrcodeLink,
    this.qrContent,
    this.checkoutUrl,
    this.deeplink,
    this.universalUrl,
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
    );
  }
}
