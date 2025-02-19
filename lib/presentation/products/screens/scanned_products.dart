import 'dart:io';
import 'package:atharitmt/core/constants/app_colors.dart';
import 'package:atharitmt/core/services/ttsservices/tts_services.dart';
import 'package:flutter/material.dart';
import 'package:atharitmt/presentation/home/controllers/food_controller.dart';
import 'package:get/get.dart';

class ScannedProductsPage extends StatelessWidget {
  final TextRecognitionController controller = Get.put(TextRecognitionController());

   ScannedProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text("Scanned Products",style: TextStyle(color: kWhite),),
        backgroundColor: kBlack,
      ),
      backgroundColor: kBlack,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() => ListView.builder(
            //shrinkWrap: true,
            itemCount: controller.scannedProducts.length,
            itemBuilder: (context, index) {
              var product = controller.scannedProducts[index];
              return Card(
                color: _getCardColor(product.status),
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  onTap: () {
                    speakStatus(product.status);
                  },
                  leading: product.imagePath.isNotEmpty
                      ? Image.file(File(product.imagePath), width: 50, height: 50, fit: BoxFit.cover)
                      : const Icon(Icons.image, size: 50, color: kWhite),
                  title: Text(product.expiryDate, style: const TextStyle(color: kWhite)),
                  subtitle: Text(product.status, style: const TextStyle(color:kWhite)),
                ),
              );
            },
          )),
        ),
      ),
    );
  }

  Color _getCardColor(String status) {
    switch (status) {
      case 'Safe to consume':
        return kGreen;
      case 'Approaching expiry':
        return kYellow;
      case 'Expired':
        return kRed;
      default:
        return Colors.grey[800]!;
    }
  }
}
