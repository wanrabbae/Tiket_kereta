import 'package:kai_mobile/utils/app_layout.dart';
import 'package:kai_mobile/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HotelScreen extends StatelessWidget {
  Map<String, dynamic> hotel;
  HotelScreen({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);

    return Container(
      width: size.width * 20,
      height: AppLayout.getHeight(150),
      padding: EdgeInsets.symmetric(
          horizontal: AppLayout.getWidth(15),
          vertical: AppLayout.getHeight(17)),
      margin: EdgeInsets.only(
          right: AppLayout.getWidth(17), top: AppLayout.getHeight(5)),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(color: Colors.grey.shade200, blurRadius: 30, spreadRadius: 5)
      ]),
      child: Row(
        children: [
          Container(
            height: AppLayout.getHeight(50),
            decoration: BoxDecoration(
                color: Styles.primaryColor,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/${hotel['image']}"))),
          ),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hotel['title'],
                style: Styles.headLineStyle2.copyWith(color: Styles.kakiColor),
              ),
              const Gap(5),
              Text(
                hotel['description'],
                style: Styles.headLineStyle4.copyWith(
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
