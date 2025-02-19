import 'package:atharitmt/presentation/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

class HomeSplash extends StatelessWidget {
  const HomeSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
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
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ExpiryDateScanner();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Colors.white)),
                  child: Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ));
  }
}
