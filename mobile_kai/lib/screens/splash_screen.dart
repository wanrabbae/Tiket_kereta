import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kai_mobile/screens/bottom_bar.dart';
import 'package:kai_mobile/screens/home_screen.dart';
import 'package:kai_mobile/utils/app_styles.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SwitchPage() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomBar(0)),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SwitchPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "WAN.KAI",
                style: GoogleFonts.josefinSans(
                    textStyle: Styles.headLineStyle1.copyWith(
                        color: Styles.primaryBold,
                        fontSize: 50,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 15,
              ),
              Lottie.asset(
                "assets/images/train_loader.json",
              ),
            ]),
      ),
    );
  }
}
