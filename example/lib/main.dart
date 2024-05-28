import 'package:binance_pay/binance_pay.dart';
import 'package:flutter/material.dart';

import '.env.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binance Pay Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Binance Pay Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Cup Cake  \$ 1.01',
            ),
            TextButton(
                onPressed: () {
                  makePayment();
                },
                child: const Text('Buy Now')),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    BinancePay pay = BinancePay(
      apiKey: apiKey,
      apiSecretKey: apiSecret,
    );

    String tradeNo = generateMerchantTradeNo();

    OrderResponse response = await pay.createOrder(
      body: RequestBody(
        merchantTradeNo: tradeNo,
        orderAmount: '1.01',
        currency: 'BUSD',
        description: 'A delicious cup cake',
        goodsList: [
          GoodsModel(
            goodsType: '01',
            goodsCategory: '1000',
            referenceGoodsId: '1234567',
            goodsName: 'Cup Cake',
            goodsDetail: 'A Yummy cup cake.',
          ),
        ],
      ),
    );

    ///query the order
    QueryResponse queryResponse = await pay.queryOrder(
      merchantTradeNo: tradeNo,
      prepayId: response.data?.prepayId,
    );

    debugPrint(queryResponse.status);

    ///close the order
    CloseResponse closeResponse = await pay.closeOrder(
      merchantTradeNo: tradeNo,
    );

    debugPrint(closeResponse.status);
  }
}
