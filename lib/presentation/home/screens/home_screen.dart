import 'package:atharitmt/core/services/barcodeservices/barcode_services.dart';
import 'package:atharitmt/core/services/ttsservices/tts_services.dart';
import 'package:atharitmt/presentation/home/controllers/food_controller.dart';
import 'package:atharitmt/presentation/products/screens/scanned_products.dart';
import 'package:atharitmt/presentation/home/widgets/scan_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpiryDateScanner extends StatelessWidget {
  final TextRecognitionController controller =
      Get.put(TextRecognitionController());
  //final FlutterTts flutterTts = FlutterTts();

  ExpiryDateScanner({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20, top: 100, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Elsecontainer(),
                const SizedBox(height: 20),
                Obx(() => Text(
                      'Detected Expiry Date: ${controller.expiryDate.value}',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                const SizedBox(height: 20),
                Obx(() {
                  String status = controller.expiryStatus.value;
                  Color statusColor;

                  if (status == 'Safe to consume') {
                    statusColor = Colors.green;
                  } else if (status == 'Approaching expiry') {
                    statusColor = Colors.yellow;
                  } else if (status == 'Expired') {
                    statusColor = Colors.red;
                  } else {
                    statusColor = Colors.grey;
                  }

                  return Column(
                    children: [
                      Text(
                        status,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: statusColor),
                      ),
                      const SizedBox(height: 10),

                      // Speak Button
                      ElevatedButton(
                        onPressed: () => speakStatus(" $status"),
                        child: const Text("Speak Status"),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.scanExpiryDate,
                  child: const Text('Scan Expiry Date'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: scanBarcode, // Trigger barcode scanner
                  child: const Text('Scan Product Barcode'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the page displaying the scanned products
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScannedProductsPage()),
                    );
                  },
                  child: const Text('View Scanned Products'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
