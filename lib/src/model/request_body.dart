// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestBody {
  ///This parameter specifies the terminal type of the merchant service. The following are the valid values for this parameter:
  ///
  /// * **APP**: This value indicates that the client-side terminal type is a mobile application.
  ///
  /// * **WEB**: This value indicates that the client-side terminal type is a website that is opened via a PC browser.
  ///
  /// * **WAP**: This value indicates that the client-side terminal type is an HTML page that is opened via a mobile browser.
  ///
  /// * **MINI_PROGRAM**: This value indicates that the terminal type of the merchant side is a mini program on the mobile phone.
  ///
  /// * **OTHERS**: This value indicates other undefined types.
  ///
  /// Default is `terminalType = APP`
  final String terminalType;

  ///The order id for the request.
  ///
  /// This variable is a unique identifier for the request
  /// and should only contain letters and digits. No other symbols are
  ///  allowed, and the maximum length is 32 characters.
  ///
  ///```
  ///
  /// BinancePay pay = ...
  /// String merchantTradeNo pay.generateMerchantTradeNo();
  ///
  /// ```
  ///
  String merchantTradeNo;

  /// The amount of the order to be paid in decimal format with 8 decimal places.
  ///
  /// This variable should be a [String] and represent the amount of the order to be paid in decimal format with 8 decimal places. The minimum amount allowed is 0.00000001.
  ///
  /// Example usage:
  ///
  ///```
  /// String orderAmount = '0.00000123';
  /// String orderAmount = '1.59';
  /// String orderAmount = '10.00';
  /// ```
  ///
  final String orderAmount;

  /// [currency] represents the order currency in UPPERCASE. Only cryptocurrency is accepted e.g. "USDT", "BNB", "BTC",
  ///
  /// fiat is not supported. It is a [String] type variable.
  final String currency;

  /// A description of the goods being purchased.
  ///
  /// This description will be displayed on the checkout page as both the
  /// product name and product details.
  ///
  final String description;

  /// A list of goods that can be purchased.
  ///
  /// See [GoodsModel] for more details
  final List<GoodsModel> goodsList;

  RequestBody({
    this.terminalType = 'APP',
    required this.merchantTradeNo,
    required this.orderAmount,
    required this.currency,
    required this.description,
    required this.goodsList,
  });
}

///

class GoodsModel {
  /// Represents the type of goods for an order in a Binance Pay transaction.
  ///
  /// The possible values for [goodsType] are:
  /// * '01': for Tangible Goods
  /// * '02': for Virtual Goods
  ///
  final String goodsType;

  ///A string representing the category of goods for a payment order.
  ///
  ///The category should be a four-digit string in the format of "XXXX", where
  ///the first digit represents the major category and the remaining three digits
  ///represent the sub-category. The possible major categories are:
  ///
  ///* 0000: Electronics & Computers
  ///* 1000: Books, Music & Movies
  ///* 2000: Home, Garden & Tools
  ///* 3000: Clothes, Shoes & Bags
  ///* 4000: Toys, Kids & Baby
  ///* 5000: Automotive & Accessories
  ///* 6000: Game & Recharge
  ///* 7000: Entertainament & Collection
  ///* 8000: Jewelry
  ///* 9000: Domestic service
  ///* A000: Beauty care
  ///* B000: Pharmacy
  ///* C000: Sports & Outdoors
  ///* D000: Food, Grocery & Health products
  ///* E000: Pet supplies
  ///* F000: Industry & Science
  ///* Z000: Others
  ///
  final String goodsCategory;

  ///The unique ID to identify the goods.
  final String referenceGoodsId;

  /// The name of the goods being purchased.
  ///
  /// The name must be a string with a maximum length of 256 characters.
  /// Special characters such as quotation marks or emojis are not allowed.
  final String goodsName;

  ///Detailed description of the goods being purchased.
  final String goodsDetail;

  GoodsModel({
    required this.goodsType,
    required this.goodsCategory,
    required this.referenceGoodsId,
    required this.goodsName,
    required this.goodsDetail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'goodsType': goodsType,
      'goodsCategory': goodsCategory,
      'referenceGoodsId': referenceGoodsId,
      'goodsName': goodsName,
      'goodsDetail': goodsDetail,
    };
  }

  factory GoodsModel.fromMap(Map<String, dynamic> map) {
    return GoodsModel(
      goodsType: map['goodsType'] as String,
      goodsCategory: map['goodsCategory'] as String,
      referenceGoodsId: map['referenceGoodsId'] as String,
      goodsName: map['goodsName'] as String,
      goodsDetail: map['goodsDetail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GoodsModel.fromJson(String source) =>
      GoodsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
