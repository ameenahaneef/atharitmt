import 'package:atharitmt/core/constants/app_colors.dart';
import 'package:atharitmt/presentation/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

class HomeSplash extends StatelessWidget {
  const HomeSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBlack,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const Image(
                image: AssetImage(
                    'assets/fantabulous image for food expiry date detection app with black background.png'),
                height: 600,
              ),
              const Center(
                  child: Text(
                'Expired or Not? Whats the date on your\n                       food mean',
                style: TextStyle(color: kWhite, fontSize: 20),
              )),
              height20,
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
                      return ExpiryDateScanner();
                    }),(route)=>false);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(color: kWhite)),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(color: kWhite),
                  ))
            ],
          ),
        ));
  }
}
