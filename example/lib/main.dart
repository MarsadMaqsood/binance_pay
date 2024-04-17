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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Cup Cake  \$ 1.0',
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

  makePayment() async {
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
        goodsType: '01',
        goodsCategory: '1000',
        referenceGoodsId: 'referenceGoodsId',
        goodsName: 'goodsName',
        goodsDetail: 'goodsDetail',
      ),
    );

    ///query the order
    QueryResponse queryResponse = await pay.queryOrder(
      merchantTradeNo: tradeNo,
      prepayId: response.data!.prepayId,
    );

    debugPrint(queryResponse.status);

    ///close the order
    CloseResponse closeResponse = await pay.closeOrder(
      merchantTradeNo: tradeNo,
    );

    debugPrint(closeResponse.status);
  }
}
