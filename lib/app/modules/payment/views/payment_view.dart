import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Pembayaran',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.blueGrey[50],
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Rp. 14.000',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Order ID #293482984928492894289',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Pilih dalam: Countdown 23:20:20',
                  style: TextStyle(
                    color: Colors.blue.shade900,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                shrinkWrap: true,
                children: [
                  PaymentMethodTile(
                    title: 'QRIS',
                    detailsWidget: QRISPaymentUI(),
                    image: Image.asset(
                      'assets/images/qris.jpg',
                      width: 64, // Lebar tetap
                      height: 64, // Tinggi tetap
                    ),
                  ),
                  PaymentMethodTile(
                    title: 'GoPay',
                    detailsWidget: GoPayPaymentUI(),
                    image: Image.asset(
                      'assets/images/gopay.png',
                      width: 64, // Lebar tetap
                      height: 64, // Tinggi tetap
                    ),
                  ),
                  PaymentMethodTile(
                    title: 'ShopeePay',
                    detailsWidget: ShopeePayPaymentUI(),
                    image: Image.asset(
                      'assets/images/shopee.png',
                      width: 64, // Lebar tetap
                      height: 64, // Tinggi tetap
                    ),
                  ),
                  PaymentMethodTile(
                    title: 'BCA Virtual Account',
                    detailsWidget: BCAVirtualAccountUI(),
                    image: Image.asset(
                      'assets/images/bca.png',
                      width: 64, // Lebar tetap
                      height: 64, // Tinggi tetap
                    ),
                  ),
                  PaymentMethodTile(
                    title: 'BNI Virtual Account',
                    detailsWidget: BNIVirtualAccountUI(),
                    image: Image.asset(
                      'assets/images/bni.jpg',
                      width: 40, // Lebar tetap
                      height: 40, // Tinggi tetap
                    ),
                  ),
                  PaymentMethodTile(
                    title: 'BRI Virtual Account',
                    detailsWidget: BRIVirtualAccountUI(),
                    image: Image.asset(
                      'assets/images/bri.png',
                      width: 40, // Lebar tetap
                      height: 40, // Tinggi tetap
                    ),
                  ),
                  PaymentMethodTile(
                    title: 'Mandiri Virtual Account',
                    detailsWidget: MandiriVirtualAccountUI(),
                    image: Image.asset(
                      'assets/images/mandiri.png',
                      width: 40, // Lebar tetap
                      height: 40, // Tinggi tetap
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentMethodTile extends StatelessWidget {
  final String title;
  final Widget detailsWidget;
  final Image image;

  PaymentMethodTile({
    required this.title,
    required this.detailsWidget,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        leading: ClipOval(
          child: Container(
            width: 30, // Lebar tetap
            height: 30, // Tinggi tetap
            color: Colors.white,
            child: Center(child: image),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: [detailsWidget],
      ),
    );
  }
}

Widget QRISPaymentUI() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(
      'QRIS Payment UI',
      style: TextStyle(fontSize: 16),
    ),
  );
}

Widget GoPayPaymentUI() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(
      'GoPay Payment UI',
      style: TextStyle(fontSize: 16),
    ),
  );
}

Widget ShopeePayPaymentUI() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(
      'ShopeePay Payment UI',
      style: TextStyle(fontSize: 16),
    ),
  );
}

Widget BCAVirtualAccountUI() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(
      'BCA Virtual Account Payment UI',
      style: TextStyle(fontSize: 16),
    ),
  );
}

Widget BNIVirtualAccountUI() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(
      'BNI Virtual Account Payment UI',
      style: TextStyle(fontSize: 16),
    ),
  );
}

Widget BRIVirtualAccountUI() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(
      'BRI Virtual Account Payment UI',
      style: TextStyle(fontSize: 16),
    ),
  );
}

Widget MandiriVirtualAccountUI() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(
      'Mandiri Virtual Account Payment UI',
      style: TextStyle(fontSize: 16),
    ),
  );
}
