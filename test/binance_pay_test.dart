import 'package:binance_pay/binance_pay.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:binance_pay/.env.dart';

void main() {
  test('Make Pay', () async {
    BinancePay pay = BinancePay(
      apiKey: apiKey,
      apiSecretKey: apiSecret,
    );

    String tradeNo = generateMerchantTradeNo();

    // OrderResponse response = await pay.createOrder(
    //   body: RequestBody(
    //     merchantTradeNo: tradeNo,
    //     orderAmount: '1.01',
    //     currency: 'BUSD',
    //     goodsType: '01',
    //     goodsCategory: '1000',
    //     referenceGoodsId: 'referenceGoodsId',
    //     goodsName: 'goodsName',
    //     goodsDetail: 'goodsDetail',
    //   ),
    // );

    // // print('object');

    // print(response.data?.prepayId);

    // await Future.delayed(const Duration(seconds: 20));

    // await pay.queryOrder(
    //   merchantTradeNo: tradeNo,
    //   prepayId: response.data?.prepayId ?? 'scacs',
    //   // prepayId: response.data!.prepayId,
    // );

    await pay.closeOrder(
      merchantTradeNo: tradeNo,
    );

    // print(response.status);
    // print(response.data);

    // print(genSign());
    // await pay.makePayment();
  });
}
