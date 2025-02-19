import 'package:atharitmt/core/constants/app_colors.dart';
import 'package:atharitmt/core/services/barcodeservices/barcode_services.dart';
import 'package:atharitmt/core/services/ttsservices/tts_services.dart';
import 'package:atharitmt/presentation/home/controllers/food_controller.dart';
import 'package:atharitmt/presentation/home/widgets/column_widget.dart';
import 'package:atharitmt/presentation/products/screens/scanned_products.dart';
import 'package:atharitmt/presentation/home/widgets/scan_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpiryDateScanner extends StatelessWidget {
  final TextRecognitionController controller =
      Get.put(TextRecognitionController());
      

  ExpiryDateScanner({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20, top: 100, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Elsecontainer(),
                height20,
                Obx(() => Text(
                      'Detected Expiry Date: ${controller.expiryDate.value}',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kWhite),
                    )),
                height20,
                Obx(() {
                  String status = controller.expiryStatus.value;
                  Color statusColor;

                  if (status == 'Safe to consume') {
                    statusColor = kGreen;
                  } else if (status == 'Approaching expiry') {
                    statusColor = kYellow;
                  } else if (status == 'Expired') {
                    statusColor = kRed;
                  } else {
                    statusColor = kGrey;
                  }
speakStatus(status);
                  return ColumnWidget(status: status, statusColor: statusColor);
                }),
                height10,
                ElevatedButton(
                  onPressed: controller.scanExpiryDate,
                  child: const Text('Scan Expiry Date'),
                ),
                height20,
                const ElevatedButton(
                  onPressed: scanBarcode,
                  child: Text('Scan Product Barcode'),
                ),
                height20,
                ElevatedButton(
                  onPressed: () {
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

