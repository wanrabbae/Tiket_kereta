import 'package:intl/intl.dart';
import 'package:kai_mobile/core/provider/HistoryTicket.dart';
import 'package:kai_mobile/core/utils/constant.dart';
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
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  List<Widget> getPassengers(passengers) {
    List<Widget> childs = [];
    for (var i = 0; i < passengers.length; i++) {
      var psg = passengers[i];
      childs.add(Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PairedColumnWidget(
                firstText: psg["name"] ?? "Alwan",
                secondText: "Passenger",
                alignment: CrossAxisAlignment.start,
                isColor: false,
              ),
              PairedColumnWidget(
                firstText: psg["seat"]["seat"].toString() ?? "0",
                secondText: "Kursi",
                alignment: CrossAxisAlignment.center,
                isColor: false,
              ),
              PairedColumnWidget(
                firstText: psg["status"].toString().toUpperCase() ?? "Tuan",
                secondText: "Status",
                alignment: CrossAxisAlignment.end,
                isColor: false,
              )
            ],
          ),
          SizedBox(
            height: 20,
            child: LayoutBuilderWidget(
              sections: 15,
              isColor: false,
              width: 8,
            ),
          )
        ],
      ));
    }
    return childs;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HistoryTicket(),
      child: Consumer<HistoryTicket>(
        builder: (context, historyProv, child) {
          return historyProv.isLoading == true
              ? Center(
                  child: Lottie.network(loading),
                )
              : Scaffold(
                  appBar: AppBar(
                    title: Text('Riwayat Tiket'),
                    backgroundColor: Styles.primaryBold,
                    automaticallyImplyLeading: false,
                  ),
                  backgroundColor: Styles.bgColor,
                  body: ListView.builder(
                    itemCount: historyProv.tickets.length > 0
                        ? historyProv.tickets.length
                        : 0,
                    padding: EdgeInsets.symmetric(
                        horizontal: AppLayout.getWidth(20),
                        vertical: AppLayout.getHeight(20)),
                    itemBuilder: (context, index) {
                      var ticket = historyProv.tickets[index];
                      print(ticket);
                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding:
                                EdgeInsets.only(left: AppLayout.getHeight(15)),
                            child: TicketView(
                              ticket: ticket,
                              isColor: true,
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Column(
                                    children: getPassengers(
                                        ticket["passengers"] ?? []),
                                  ),
                                  Gap(AppLayout.getHeight(15)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      PairedColumnWidget(
                                        firstText:
                                            ticket["id"].toString() ?? "",
                                        secondText: "Number of E-tickets",
                                        alignment: CrossAxisAlignment.start,
                                        isColor: false,
                                      ),
                                      PairedColumnWidget(
                                        firstText: ticket["booking_code"] ?? "",
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "SCAN BARCODE",
                                            style: Styles.headLineStyle4
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 13),
                                          ),
                                          const Gap(5),
                                          Text(
                                            "Payment Method",
                                            style: Styles.headLineStyle4
                                                .copyWith(fontSize: 12),
                                          )
                                        ],
                                      ),
                                      PairedColumnWidget(
                                        firstText: NumberFormat.currency(
                                                locale: "id",
                                                symbol: "Rp. ",
                                                decimalDigits: 0)
                                            .format(ticket["payment_total"])
                                            .toString(),
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
                                    bottomRight: Radius.circular(
                                        AppLayout.getHeight(21)),
                                    bottomLeft: Radius.circular(
                                        AppLayout.getHeight(21)))),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppLayout.getWidth(15)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    AppLayout.getHeight(15)),
                                child: BarcodeWidget(
                                  barcode: Barcode.code128(),
                                  data: 'https://github.com/wanrabbae',
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
                            padding:
                                EdgeInsets.only(left: AppLayout.getHeight(15)),
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
        },
      ),
    );
  }
}
