// // import 'dart:io';
// // import 'package:atharitmt/presentation/home/controllers/food_controller.dart';
// // import 'package:atharitmt/presentation/home/widgets/scan_container.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_tts/flutter_tts.dart';
// // import 'package:get/get.dart';

// // class ExpiryDateScanner extends StatelessWidget {
// //   final TextRecognitionController controller = Get.put(TextRecognitionController());
// //   final FlutterTts flutterTts = FlutterTts();



// //   ExpiryDateScanner({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       body: SingleChildScrollView(
// //         child: Center(
// //           child: Padding(
// //             padding: const EdgeInsets.only(left: 20,right: 20,top: 100,bottom: 20),
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: <Widget>[
// //                 Elsecontainer(),
// //                 SizedBox(height: 20),
// //                 // Use Obx to update the UI when the state changes
// //                 Obx(() => Text('Detected Expiry Date:${controller.expiryDate.value}',
// //                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
// //                 )),
// //                 SizedBox(height: 20),
// //                 Obx(() {
// //                   String status = controller.expiryStatus.value;
// //                   Color statusColor;
                    
// //                   if (status == 'Safe to consume') {
// //                     statusColor = Colors.green;
// //                   } else if (status == 'Approaching expiry') {
// //                     statusColor = Colors.yellow;
// //                   } else if (status == 'Expired') {
// //                     statusColor = Colors.red;
// //                   } else {
// //                     statusColor = Colors.grey;
// //                   }
                  
// //                   return Text(
// //                     status,
// //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: statusColor),
// //                   );
// //                 }),
// //                 SizedBox(height: 10),
// //                 ElevatedButton(
// //                   onPressed: controller.scanExpiryDate,
// //                   child: Text('Scan Expiry Date'),
// //                 ),
// //                 //SizedBox(height: 20),
// //               Obx(() => ListView.builder(
// //                 shrinkWrap: true,
// //                 itemCount: controller.scannedProducts.length,
// //                 itemBuilder: (context, index) {
// //                   var product = controller.scannedProducts[index];
// //                   return Card(
// //                     color:_getCardColor(product.status),
// //                     margin: EdgeInsets.all(8),
// //                     child: ListTile(
// //                       leading: product.imagePath.isNotEmpty
// //                           ? Image.file(File(product.imagePath), width: 50, height: 50, fit: BoxFit.cover)
// //                           : Icon(Icons.image, size: 50, color: Colors.white),
// //                       title: Text(product.expiryDate, style: TextStyle(color: Colors.white)),
// //                       subtitle: Text(product.status, style: TextStyle(color: Colors.white)),
// //                     ),
// //                   );
// //                 },
// //               )),
                     
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //   Color _getCardColor(String status) {
// //   switch (status) {
// //     case 'Safe to consume':
// //       return Colors.green; // Green for active products
// //     case 'Approaching expiry':
// //       return Colors.red; // Red for inactive products
// //     case 'Expired':
// //       return Colors.orange; // Orange for pending status
// //     default:
// //       return Colors.grey[800]!; // Default color if no status matches
// //   }
// // }
// // }

import 'dart:io';
import 'package:atharitmt/presentation/home/controllers/food_controller.dart';
import 'package:atharitmt/presentation/home/widgets/scan_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class ExpiryDateScanner extends StatelessWidget {
  final TextRecognitionController controller = Get.put(TextRecognitionController());
  final FlutterTts flutterTts = FlutterTts();

  ExpiryDateScanner({super.key});

  void speakStatus(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Elsecontainer(),
                SizedBox(height: 20),
                
                // Expiry Date Display
                Obx(() => Text(
                  'Detected Expiry Date: ${controller.expiryDate.value}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                )),
                SizedBox(height: 20),

                // Expiry Status with Speech
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
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: statusColor),
                      ),
                      SizedBox(height: 10),

                      // Speak Button
                      ElevatedButton(
                        onPressed: () => speakStatus(" $status"),
                        child: Text("Speak Status"),
                      ),
                    ],
                  );
                }),

                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.scanExpiryDate,
                  child: Text('Scan Expiry Date'),
                ),

                SizedBox(height: 20),
                Obx(() => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.scannedProducts.length,
                      itemBuilder: (context, index) {
                        var product = controller.scannedProducts[index];
                        return Card(
                          color: _getCardColor(product.status),
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            leading: product.imagePath.isNotEmpty
                                ? Image.file(File(product.imagePath), width: 50, height: 50, fit: BoxFit.cover)
                                : Icon(Icons.image, size: 50, color: Colors.white),
                            title: Text(product.expiryDate, style: TextStyle(color: Colors.white)),
                            subtitle: Text(product.status, style: TextStyle(color: Colors.white)),
                          ),
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getCardColor(String status) {
    switch (status) {
      case 'Safe to consume':
        return Colors.green;
      case 'Approaching expiry':
        return Colors.orange;
      case 'Expired':
        return Colors.red;
      default:
        return Colors.grey[800]!;
    }
  }
}

