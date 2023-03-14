import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/style.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:kai_mobile/core/provider/HistoryTicket.dart';
import 'package:kai_mobile/core/utils/constant.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/screens/bottom_bar.dart';
import 'package:kai_mobile/screens/ticket_view.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:kai_mobile/utils/app_info_list.dart';
import 'package:kai_mobile/utils/app_layout.dart';
import 'package:kai_mobile/utils/app_styles.dart';
import 'package:kai_mobile/widgets/layout_builder_widget.dart';
import 'package:kai_mobile/widgets/paired_column_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class NewTicket extends StatefulWidget {
  final List dataTicket;
  const NewTicket(@required this.dataTicket);

  @override
  State<NewTicket> createState() => _NewTicketState();
}

class _NewTicketState extends State<NewTicket> {
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
              psg["seat"] != null
                  ? PairedColumnWidget(
                      firstText: psg["seat"]["seat"].toString() ?? "0",
                      secondText: "Kursi",
                      alignment: CrossAxisAlignment.center,
                      isColor: false,
                    )
                  : Text(""),
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

  void cetak(data) async {
    final pdf = pw.Document();
    var totalPay =
        NumberFormat.currency(locale: "id", symbol: "Rp. ", decimalDigits: 0)
            .format(data["payment_total"])
            .toString();
    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a6,
          build: (pw.Context context) {
            return pw.Container(
                child: pw.Column(
              children: [
                pw.Text("Pemesanan Tiket " + data?["booking_code"],
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontSize: 20)),
                pw.SizedBox(
                  height: 20,
                ),
                pw.Text("Tanggal Pemesanan: " + data?["booking_date"]),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Text('Total Bayar: $totalPay'),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Text("Nomor Kereta: " + data?["train_no"]),
                pw.SizedBox(height: 30),
                pw.Container(
                    padding: pw.EdgeInsets.only(
                        top: AppLayout.getHeight(20),
                        bottom: AppLayout.getHeight(20)),
                    margin: pw.EdgeInsets.only(
                        left: AppLayout.getHeight(15),
                        right: AppLayout.getHeight(15)),
                    decoration: pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.only(
                            bottomRight:
                                pw.Radius.circular(AppLayout.getHeight(21)),
                            bottomLeft:
                                pw.Radius.circular(AppLayout.getHeight(21)))),
                    child: pw.Container(
                      padding: pw.EdgeInsets.symmetric(
                          horizontal: AppLayout.getWidth(15)),
                      child: pw.ClipRRect(
                        child: pw.BarcodeWidget(
                          barcode: Barcode.code128(),
                          data: 'https://github.com/wanrabbaeee',
                          drawText: false,
                          width: double.infinity,
                          height: 70,
                        ),
                      ),
                    ))
              ],
            ));
          }),
    );

    Uint8List bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${data["booking_code"]}.pdf');

    await file.writeAsBytes(bytes);

    await OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  goRemove(BottomBar(0));
                },
                child: Container(
                    padding: EdgeInsets.only(right: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          PhosphorIcons.xBold,
                          size: 35,
                        ),
                      ],
                    )),
              ),
              ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal: AppLayout.getWidth(20),
                    vertical: AppLayout.getHeight(20)),
                itemBuilder: (context, index) {
                  var ticket = widget.dataTicket[index];
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 5),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Column(
                                children:
                                    getPassengers(ticket["passengers"] ?? []),
                              ),
                              Gap(AppLayout.getHeight(15)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PairedColumnWidget(
                                    firstText: ticket["id"].toString() ?? "",
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
                                        style: Styles.headLineStyle4.copyWith(
                                            color: Colors.black, fontSize: 13),
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
                                bottomRight:
                                    Radius.circular(AppLayout.getHeight(21)),
                                bottomLeft:
                                    Radius.circular(AppLayout.getHeight(21)))),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppLayout.getWidth(15)),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(AppLayout.getHeight(15)),
                            child: BarcodeWidget(
                              barcode: Barcode.code128(),
                              data: 'https://github.com/wanrabbaeee',
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
                    ],
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  goRemove(BottomBar(0));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppLayout.getWidth(10)),
                      color: Styles.primaryBold),
                  child: Center(
                      child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.home_filled,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                            text: "Beranda", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  goRemove(BottomBar(1));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Styles.primaryBold, width: 1),
                      borderRadius:
                          BorderRadius.circular(AppLayout.getWidth(10)),
                      color: Styles.bgColor),
                  child: Center(
                      child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.history,
                            size: 20,
                            color: Styles.primaryBold,
                          ),
                        ),
                        TextSpan(
                            text: "Riwayat Tiket",
                            style: TextStyle(
                                fontSize: 16, color: Styles.primaryBold)),
                      ],
                    ),
                  )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  cetak(widget.dataTicket[0]);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Styles.primaryBold, width: 1),
                      borderRadius:
                          BorderRadius.circular(AppLayout.getWidth(10)),
                      color: Styles.bgColor),
                  child: Center(
                      child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.document_scanner,
                            size: 20,
                            color: Styles.primaryBold,
                          ),
                        ),
                        TextSpan(
                            text: "Cetak Tiket",
                            style: TextStyle(
                                fontSize: 16, color: Styles.primaryBold)),
                      ],
                    ),
                  )),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
