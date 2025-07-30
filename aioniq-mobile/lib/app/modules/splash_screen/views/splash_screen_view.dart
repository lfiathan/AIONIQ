import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff60AB4D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/logo/Logo_Apens-iot_+_Text__Warna_Putih_-removebg-preview.png'),
              width: 200,
            ),
            SizedBox(
              height: 20,
            ),
            SpinKitWaveSpinner(
              color: Colors.white,
              size: 50.0,
              waveColor: Colors.white,
              trackColor: Colors.black26,
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: Text("v1.0.0", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
      ),
    );
  }
}
