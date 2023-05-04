 [![Version](https://img.shields.io/pub/v/binance_pay?color=%2354C92F&logo=dart)](https://pub.dev/packages/binance_pay/install) 
 
 
## ⭐  Installing

```yaml
dependencies:
    binance_pay: ^0.0.2
```
## ⚡ Import

```dart
import 'package:binance_pay/binance_pay.dart';
```

## 📙 How To Use

```dart
BinancePay pay = BinancePay(
    apiKey: apiKey,
    apiSecretKey: apiSecret,
);
```

### Create an order
Returns <a href="https://pub.dev/documentation/binance_pay/latest/binance_pay/OrderResponse-class.html">OrderResponse</a>
```dart
String merchantTradeNo = generateMerchantTradeNo();

//Create an order
OrderResponse response = await pay.createOrder(
    body: RequestBody(
        merchantTradeNo: merchantTradeNo,
        orderAmount: '1.01',
        currency: 'BUSD',
        goodsType: '01',
        goodsCategory: '1000',
        referenceGoodsId: '1234567',
        goodsName: 'Cup Cake',
        goodsDetail: 'A Yummy cup cake.',
    ),
);

```

### Query the order
Returns <a href="https://pub.dev/documentation/binance_pay/latest/binance_pay/QueryResponse-class.html">QueryResponse</a>
```dart

//Query the order
QueryResponse queryResponse = await pay.queryOrder(
    merchantTradeNo: merchantTradeNo,
    prepayId: response.data!.prepayId,
);

```

### Close the order
Returns <a href="https://pub.dev/documentation/binance_pay/latest/binance_pay/CloseResponse-class.html">CloseResponse</a>
```dart

//Close the order
CloseResponse closeResponse = await pay.closeOrder(
    merchantTradeNo: merchantTradeNo,
);




```