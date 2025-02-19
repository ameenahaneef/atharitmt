

import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> fetchProductDetails(String barcode) async {
    final String url = 'https://world.openfoodfacts.org/api/v0/product/$barcode.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data); 
      if (data['product'] != null) {
        
        showProductDetails(data['product']);
      } else {
        Get.snackbar('Product Not Found', 'No product data available for this barcode.',colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red);
      }
    } else {
      Get.snackbar('Error', 'Failed to load product data.', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void showProductDetails(Map<String, dynamic> product) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product['product_name'] ?? 'Unknown Product',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text("Brand: ${product['brands'] ?? 'Unknown'}"),
          Text("Category: ${product['categories'] ?? 'Unknown'}"),
          const SizedBox(height: 20),
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


  // Barcode scanner function
  Future<void> scanBarcode() async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', // Scanner color
      'Cancel',  // Cancel button text
      true,      // Show flash icon
      ScanMode.BARCODE, // Only barcode scanning
    );
     await Future.delayed(const Duration(milliseconds: 500));

    if (barcode != '-1') {
      fetchProductDetails(barcode);
    }else{
      // You can add some feedback here if needed
    Get.snackbar("Scan Cancelled", "No barcode detected.");
    }
  }
