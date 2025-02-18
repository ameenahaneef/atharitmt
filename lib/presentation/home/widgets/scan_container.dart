import 'package:atharitmt/presentation/home/controllers/food_controller.dart';
import 'package:flutter/material.dart';

class Elsecontainer extends StatelessWidget {
  const Elsecontainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(252, 30, 29, 29),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(30)),
        width: 300,
        height: 420,
        child: IconButton(
            onPressed: () {
              TextRecognitionController().scanExpiryDate();
            },
            icon: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
              size: 50,
            )),
      ),
    );
  }
}
