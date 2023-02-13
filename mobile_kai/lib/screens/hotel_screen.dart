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
      margin: EdgeInsets.only(
          right: AppLayout.getWidth(17), top: AppLayout.getHeight(15)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(7),
            topRight: Radius.circular(7),
            bottomLeft: Radius.circular(7),
            bottomRight: Radius.circular(7)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: double.infinity,
            width: 100,
            child: Image.network(
              hotel['image'],
              fit: BoxFit.cover,
            ),
          ),
          const Gap(10),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppLayout.getWidth(10),
                vertical: AppLayout.getHeight(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  hotel['title'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      Styles.headLineStyle2.copyWith(color: Styles.orangeColor),
                ),
                const Gap(5),
                SizedBox(
                  width: 170.0,
                  child: Text(
                    hotel['description'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Colors.black87, fontSize: 13),
                  ),
                ),
                SizedBox(
                  child: Text(
                    "2022-10-10:08.00",
                    style: Styles.headLineStyle4
                        .copyWith(color: Colors.grey[400], fontSize: 12),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
