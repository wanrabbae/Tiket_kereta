import 'package:kai_mobile/screens/ticket_view.dart';
import 'package:kai_mobile/utils/app_info_list.dart';
import 'package:kai_mobile/utils/app_layout.dart';
import 'package:kai_mobile/utils/app_styles.dart';
import 'package:kai_mobile/widgets/layout_builder_widget.dart';
import 'package:kai_mobile/widgets/paired_column_widget.dart';
import 'package:kai_mobile/widgets/ticket_tabs.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:barcode_widget/barcode_widget.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Tiket'),
        backgroundColor: Styles.primaryBold,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Styles.bgColor,
      body: ListView.builder(
        itemCount: ticketList.length,
        padding: EdgeInsets.symmetric(
            horizontal: AppLayout.getWidth(20),
            vertical: AppLayout.getHeight(20)),
        itemBuilder: (context, index) {
          var ticket = ticketList[index];
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: AppLayout.getHeight(15)),
                child: TicketView(
                  ticket: ticket,
                  isColor: true,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          PairedColumnWidget(
                            firstText: "Flutter DB",
                            secondText: "Passenger",
                            alignment: CrossAxisAlignment.start,
                            isColor: false,
                          ),
                          PairedColumnWidget(
                            firstText: "5221 345678",
                            secondText: "Passport",
                            alignment: CrossAxisAlignment.end,
                            isColor: false,
                          )
                        ],
                      ),
                      Gap(AppLayout.getHeight(15)),
                      const LayoutBuilderWidget(
                        sections: 15,
                        isColor: false,
                        width: 8,
                      ),
                      Gap(AppLayout.getHeight(15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          PairedColumnWidget(
                            firstText: "1234 456 67890",
                            secondText: "Number of E-tickets",
                            alignment: CrossAxisAlignment.start,
                            isColor: false,
                          ),
                          PairedColumnWidget(
                            firstText: "B2C57P",
                            secondText: "Booking Code",
                            alignment: CrossAxisAlignment.end,
                            isColor: false,
                          )
                        ],
                      ),
                      Gap(AppLayout.getHeight(15)),
                      const LayoutBuilderWidget(
                        sections: 15,
                        isColor: false,
                        width: 8,
                      ),
                      Gap(AppLayout.getHeight(15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/visa.png",
                                    scale: 11,
                                  ),
                                  Text(
                                    " *** 4236",
                                    style: Styles.headLineStyle3,
                                  )
                                ],
                              ),
                              const Gap(5),
                              Text(
                                "Payment Method",
                                style: Styles.headLineStyle4,
                              )
                            ],
                          ),
                          const PairedColumnWidget(
                            firstText: "\$341",
                            secondText: "Price",
                            alignment: CrossAxisAlignment.end,
                            isColor: false,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                    ],
                  ))
              // Bar code place
              ,
              const SizedBox(
                height: 1,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: AppLayout.getHeight(15),
                    right: AppLayout.getHeight(15)),
                padding: EdgeInsets.only(
                    top: AppLayout.getHeight(20),
                    bottom: AppLayout.getHeight(20)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(AppLayout.getHeight(21)),
                        bottomLeft: Radius.circular(AppLayout.getHeight(21)))),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppLayout.getWidth(15)),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppLayout.getHeight(15)),
                    child: BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: 'https://github.com/martinovovo',
                      drawText: false,
                      color: Styles.textColor,
                      width: double.infinity,
                      height: 70,
                    ),
                  ),
                ),
              ),
              Gap(AppLayout.getHeight(20)),
              Container(
                padding: EdgeInsets.only(left: AppLayout.getHeight(15)),
                child: TicketView(
                  ticket: ticket,
                ),
              ),
              // Gap(AppLayout.getHeight(40)),
              Divider(
                color: Colors.black,
                height: 50,
              )
            ],
          );
        },
      ),
    );
  }
}
