import 'dart:io';
import 'package:atharitmt/data/models/products_model.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class TextRecognitionController extends GetxController {
  var expiryDate = ''.obs;
  var expiryStatus = ''.obs;
  var scannedProducts = <ScannedProduct>[].obs;
  var pickedImagePath = ''.obs;
  late Box<ScannedProduct> box;

  @override
  void onInit() {
    super.onInit();
    box = Hive.box<ScannedProduct>('scanned_products');
    loadScannedProducts();
  }

  Future<void> scanExpiryDate() async {
    final detectedDate = await _recognizeText();
    print("Detected Expiry Date: $detectedDate");

    expiryDate.value =
        detectedDate.isNotEmpty ? detectedDate : 'Expiry date not found';

    if (detectedDate.isNotEmpty) {
      final status = _getExpiryStatus(detectedDate);
      expiryStatus.value = status;
      await saveScannedProduct();
    }
  }

  Future<void> saveScannedProduct() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      pickedImagePath.value =
          pickedFile.path; 
      final scannedProduct = ScannedProduct(
        imagePath: pickedImagePath.value,
        expiryDate: expiryDate.value,
        status: expiryStatus.value,
      );

      await box.add(scannedProduct);

      loadScannedProducts();
    } else {
      print("No image selected.");
    }
  }

  Future<String> _recognizeText() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final inputImage = InputImage.fromFile(File(pickedFile.path));
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);
      final recognizedText = await textRecognizer.processImage(inputImage);

      print("Recognized Text: ${recognizedText.text}");

      return _extractExpiryDate(recognizedText);
    } else {
      return '';
    }
  }

  String _extractExpiryDate(RecognizedText recognizedText) {
    RegExp datePattern = RegExp(
      r'(\b(?:\d{1,2}[-/\s]?\d{1,2}(?:[-/\s]?\d{4})?)\b|\b(?:[A-Za-z]{3,9}\.?[-/\s]?\d{1,2},?\s?\d{4})\b|\b(?:[A-Za-z]{3}\.?[-/\s]?\d{1,2})\b)',
    );

    RegExp expiryPattern =
        RegExp(r'\b(expiry|exp|expiry date|e)\b', caseSensitive: false);

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        print("Detected line: ${line.text}"); 

        if (expiryPattern.hasMatch(line.text)) {
          final match = datePattern.firstMatch(line.text);
          if (match != null) {
            print(
                "Matched Date: ${match.group(0)}"); 
            return match.group(0) ?? '';
          }
        }
      }
    }

    return ''; 
  }


  void loadScannedProducts() {
    final products = box.values.toList();
    scannedProducts.assignAll(products);
  }

  String _getExpiryStatus(String detectedDate) {
    try {
      DateTime expiryDate;
      DateFormat dateFormat = DateFormat("MMM dd, yyyy");

      try {
        expiryDate = dateFormat.parse(detectedDate);
      } catch (e) {
        print("Error parsing date with full format: $e");
        DateFormat fallbackDateFormat1 = DateFormat("MM yyyy");
        try {
          expiryDate = fallbackDateFormat1.parse(detectedDate);
        } catch (e) {
          print("Error parsing date with MM yyyy format: $e");
          DateFormat fallbackDateFormat2 = DateFormat("yyyy");
          try {
            expiryDate = fallbackDateFormat2.parse(detectedDate);
          } catch (e) {
            print("Error parsing date with yyyy format: $e");
            return 'Invalid expiry date';
          }
        }
      }

      final DateTime currentDate = DateTime.now();
      final difference = expiryDate.difference(currentDate).inDays;

      if (difference > 7) {
        return 'Safe to consume';
      } else if (difference <= 7 && difference > 0) {
        return 'Approaching expiry';
      } else {
        return 'Expired';
      }
    } catch (e) {
      print("Error calculating expiry status: $e");
      return 'Invalid expiry date';
    }
  }
}
