import 'dart:convert';
import 'package:atharitmt/core/constants/api_endpoints.dart';
import 'package:atharitmt/core/constants/app_colors.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> fetchProductDetails(String barcode) async {
  final Uri url = Uri.parse(ApiEndpoints.getUrl(barcode));

  final response = await http.get(url);

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    print(data);
    if (data['product'] != null) {
      showProductDetails(data['product']);
    } else {
      Get.snackbar(
          'Product Not Found', 'No product data available for this barcode.',
          colorText: kWhite,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kRed);
    }
  } else {
    Get.snackbar('Error', 'Failed to load product data.',
        snackPosition: SnackPosition.BOTTOM);
  }
}




void showProductDetails(Map<String, dynamic> product) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          Text(
            product['product_name'] ?? 'Unknown Product',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          height10,
          Text("Brand: ${product['brands'] ?? 'Unknown'}"),
          Text("Category: ${product['categories'] ?? 'Unknown'}"),
          height20,
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text("Close"),
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> scanBarcode() async {
  String barcode = await FlutterBarcodeScanner.scanBarcode(
    '#ff6666',
    'Cancel',
    true,
    ScanMode.BARCODE,
  );
  await Future.delayed(const Duration(milliseconds: 500));

  if (barcode != '-1') {
    fetchProductDetails(barcode);
  } else {
    Get.snackbar("Scan Cancelled", "No barcode detected.");
  }
}
