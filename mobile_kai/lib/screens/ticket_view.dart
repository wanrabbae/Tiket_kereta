import 'package:intl/intl.dart';
import 'package:kai_mobile/utils/app_layout.dart';
import 'package:kai_mobile/utils/app_styles.dart';
import 'package:kai_mobile/widgets/layout_builder_widget.dart';
import 'package:kai_mobile/widgets/paired_column_widget.dart';
import 'package:kai_mobile/widgets/thick_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TicketView extends StatelessWidget {
  Map<String, dynamic> ticket;
  final bool? isColor;
  TicketView({super.key, required this.ticket, this.isColor});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return SizedBox(
      width: size.width * 0.85,
      // height: AppLayout.getHeight(GetPlatform.isAndroid == true ? 152 : 169),
      child: Container(
        margin: EdgeInsets.only(right: AppLayout.getHeight(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // The blue top part of the card
            Container(
              padding: EdgeInsets.all(AppLayout.getHeight(16)),
              decoration: BoxDecoration(
                  color:
                      isColor == null ? const Color(0xFF526799) : Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(21),
                      topRight: Radius.circular(21))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        ticket['train_journey']['train_station_depart']
                                ["station_code"] ??
                            "NYC",
                        style: isColor == null
                            ? Styles.headLineStyle3
                                .copyWith(color: Colors.white)
                            : Styles.headLineStyle3,
                      ),
                      const Spacer(),
                      const ThickContainer(
                        isColor: true,
                      ),
                      Expanded(
                          child: Stack(children: [
                        SizedBox(
                          height: AppLayout.getHeight(24),
                          child: const LayoutBuilderWidget(sections: 6),
                        ),
                        Center(
                          child: Icon(
                            Icons.train_rounded,
                            color: isColor == null
                                ? Colors.white
                                : const Color(0xFF8ACCF7),
                          ),
                        ),
                      ])),
                      const ThickContainer(
                        isColor: true,
                      ),
                      const Spacer(),
                      Text(
                        ticket['train_journey']['train_station_arrival']
                                ["station_code"] ??
                            "NYC",
                        style: isColor == null
                            ? Styles.headLineStyle3
                                .copyWith(color: Colors.white)
                            : Styles.headLineStyle3,
                      ),
                    ],
                  ),
                  const Gap(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: AppLayout.getWidth(100),
                          child: Text(
                            ticket['train_journey']['train_station_depart']
                                    ["station_name"] ??
                                "New-York",
                            style: isColor == null
                                ? Styles.headLineStyle4
                                    .copyWith(color: Colors.white)
                                : Styles.headLineStyle4,
                          )),
                      SizedBox(
                          width: AppLayout.getWidth(100),
                          child: Text(
                            ticket['train_journey']['train_station_arrival']
                                    ["station_name"] ??
                                "London",
                            textAlign: TextAlign.end,
                            style: isColor == null
                                ? Styles.headLineStyle4
                                    .copyWith(color: Colors.white)
                                : Styles.headLineStyle4,
                          )),
                    ],
                  )
                ],
              ),
            ),
            // The orange bottom part of the card`
            Container(
                color: isColor == null ? Styles.orangeColor : Colors.white,
                child: Row(children: [
                  SizedBox(
                    height: AppLayout.getHeight(20),
                    width: AppLayout.getWidth(10),
                    child: const DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: Colors.white)),
                  ),
                  const Expanded(
                    child: LayoutBuilderWidget(
                      isColor: false,
                      sections: 15,
                    ),
                  ),
                  SizedBox(
                    height: AppLayout.getWidth(20),
                    width: AppLayout.getHeight(10),
                    child: const DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            color: Colors.white)),
                  ),
                ])),
            // The bottom of orange card
            Container(
              padding: EdgeInsets.only(
                  left: AppLayout.getWidth(16),
                  top: AppLayout.getHeight(10),
                  right: AppLayout.getWidth(16),
                  bottom: AppLayout.getHeight(10)),
              decoration: BoxDecoration(
                  color: isColor == null ? Styles.orangeColor : Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(isColor == null ? 21 : 0),
                      bottomRight: Radius.circular(isColor == null ? 21 : 0))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PairedColumnWidget(
                        firstText: DateFormat.MMMd()
                            .format(DateTime.parse(ticket["booking_date"]))
                            .toString(),
                        secondText: "Tanggal",
                        alignment: CrossAxisAlignment.start,
                        isColor: isColor,
                      ),
                      PairedColumnWidget(
                        firstText: ticket["train_journey"]["depart_time"]
                                .split(" ")[1]
                                .split(":")[0] +
                            ":" +
                            ticket["train_journey"]["depart_time"]
                                .split(" ")[1]
                                .split(":")[1],
                        secondText: "Waktu Kedatangan",
                        alignment: CrossAxisAlignment.center,
                        isColor: isColor,
                      ),
                      PairedColumnWidget(
                        firstText: DateFormat.y()
                            .format(DateTime.parse(ticket["booking_date"]))
                            .toString(),
                        secondText: "Tahun",
                        alignment: CrossAxisAlignment.end,
                        isColor: isColor,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
