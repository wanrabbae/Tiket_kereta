import 'package:kai_mobile/screens/hotel_screen.dart';
import 'package:kai_mobile/screens/ticket_view.dart';
import 'package:kai_mobile/utils/app_info_list.dart';
import 'package:kai_mobile/utils/app_layout.dart';
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
                            "Selamat Pagi,",
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
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Dari",
                              prefixIcon: Icon(
                                Icons.departure_board,
                                color: Styles.primaryBold,
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Ke",
                              prefixIcon: Icon(
                                Icons.train_sharp,
                                color: Styles.primaryBold,
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Penumpang",
                              prefixIcon: Icon(
                                Icons.person_add_alt_rounded,
                                color: Styles.primaryBold,
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("CARI TIKET");
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppLayout.getHeight(18),
                                  horizontal: AppLayout.getWidth(15)),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      AppLayout.getWidth(10)),
                                  color: Styles.primaryBold),
                              child: Center(
                                child: Text(
                                  "Cari Tiket",
                                  style: Styles.textStyle
                                      .copyWith(color: Colors.white),
                                ),
                              )),
                        ),
                      ],
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
