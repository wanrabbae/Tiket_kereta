import 'package:kai_mobile/screens/hotel_screen.dart';
import 'package:kai_mobile/screens/ticket_view.dart';
import 'package:kai_mobile/utils/app_info_list.dart';
import 'package:kai_mobile/utils/app_styles.dart';
import 'package:kai_mobile/widgets/view_all_widget.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      extendBody: true,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Styles.primaryBold,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(children: [
                  const Gap(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Morning",
                            style: Styles.headLineStyle3
                                .copyWith(color: Colors.white),
                          ),
                          const Gap(5),
                          Text(
                            "Alwan",
                            style: Styles.headLineStyle1
                                .copyWith(color: Colors.white),
                          )
                        ],
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/img_1.png"))),
                      )
                    ],
                  ),
                  const Gap(60),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 120),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  // margin: EdgeInsets.only(top: -100),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(25),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Berita Terbaru',
              style: Styles.headLineStyle2,
            ),
          ),
          const Gap(5),
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                  children: newsList
                      .map((hotelInfo) => HotelScreen(hotel: hotelInfo))
                      .toList()))
        ],
      ),
    );
  }
}
