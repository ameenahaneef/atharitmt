import 'dart:io';
import 'package:atharitmt/core/constants/app_colors.dart';
import 'package:atharitmt/presentation/home/controllers/food_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          border: Border.all(color: kWhite),
          borderRadius: BorderRadius.circular(30),
        ),
        width: 200,
        height: 320,
        child: GetBuilder<TextRecognitionController>(
          builder: (controller) {
            if (controller.pickedImagePath.value.isNotEmpty) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.file(
                  File(controller.pickedImagePath.value),
                  width: 200,
                  height: 320,
                  fit: BoxFit.cover,
                ),
              );
            } else {
              return IconButton(
                onPressed: () {
                  controller.scanExpiryDate();
                },
                icon: const Icon(
                  Icons.qr_code_scanner,
                  color: kWhite,
                  size: 50,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
