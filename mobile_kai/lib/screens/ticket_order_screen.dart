import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kai_mobile/core/utils/custom_component.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/screens/book_seat_screen.dart';
import 'package:kai_mobile/utils/app_styles.dart';
import 'package:intl/intl.dart';

class TicketOrder extends StatefulWidget {
  final Map? dataJourney;
  const TicketOrder(@required this.dataJourney);

  @override
  State<TicketOrder> createState() => _TicketOrderState();
}

class _TicketOrderState extends State<TicketOrder> {
  List<TextEditingController> controllers = [];
  var _currencies = [
    "Tuan",
    "Tuan Muda",
    "Nyonya",
    "Nona",
  ];
  var train_fare = "0";
  var class_selected;
  bool _validate = false;
  var selectedClassData;
  var _titelSelected = null;
  final oCcy = new NumberFormat("#.##", "id_IDR");
  List<Widget> getInputPsg() {
    List<Widget> childs = [];
    for (var i = 1;
        i < int.parse(widget.dataJourney?["data"]["passengerCount"]) + 1;
        i++) {
      childs.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detail Penumpang " + i.toString(),
            style: Styles.headLineStyle2
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) {
              print(value);
            },
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Styles.primaryBold, width: 1.5)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Styles.primaryBold, width: 1.5)),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Styles.primaryBold, width: 1.5)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Styles.primaryBold, width: 1.5)),
                hintText: "Nama Lengkap",
                prefixIcon: Icon(
                  FluentSystemIcons.ic_fluent_person_accounts_regular,
                  color: Styles.primaryBold,
                )),
          ),
          SizedBox(
            height: 20,
          ),
          DropdownSearch<String>(
            popupProps: PopupProps.menu(
              showSelectedItems: true,
              disabledItemFn: (String s) => s.startsWith('I'),
            ),
            items: [
              "Tuan",
              "Tuan Muda",
              "Nyonya",
              "Nona",
            ],
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Styles.primaryBold, width: 1.5)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Styles.primaryBold, width: 1.5)),
                  errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Styles.primaryBold, width: 1.5)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Styles.primaryBold, width: 1.5)),
                  hintText: "Title",
                  prefixIcon: Icon(
                    FluentSystemIcons.ic_fluent_app_title_filled,
                    color: Styles.primaryBold,
                  )),
            ),
            onChanged: (value) {
              print(value);
            },
          ),
          Divider(
            color: Colors.grey.shade600,
            height: 50,
          )
        ],
      ));
    }
    return childs;
  }

  getClass(fares) {
    var data = fares.map((fr) => "${fr["class"]}");
    return data.toList();
  }

  getPriceClass(className, fares) {
    var data = fares.firstWhere((fr) => fr["class"] == className);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        title: Text("Pesan Tiket"),
        backgroundColor: Styles.primaryBold,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: getInputPsg(),
                ),
                DropdownSearch<dynamic>(
                  popupProps: PopupProps.menu(),
                  items: getClass(widget.dataJourney?["detail"]["train_fare"]),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Styles.primaryBold, width: 1.5)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Styles.primaryBold, width: 1.5)),
                        hintText: "Pilih Class",
                        errorText: _validate ? 'Wajib diisi!' : null,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Styles.primaryBold, width: 1.5)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Styles.primaryBold, width: 1.5)),
                        prefixIcon: Icon(
                          FluentSystemIcons.ic_fluent_ticket_filled,
                          color: Styles.primaryBold,
                        )),
                  ),
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      class_selected = value;
                      train_fare =
                          "${getPriceClass(value, widget.dataJourney?["detail"]?["train_fare"])['fare']}";
                      selectedClassData = getPriceClass(
                          value, widget.dataJourney?["detail"]?["train_fare"]);
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kereta",
                  style: Styles.headLineStyle2.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "${widget.dataJourney?['detail']?['train_station_depart']?['station_code']} - ${widget.dataJourney?['detail']?['train_station_arrival']?['station_code']}   |   ${widget.dataJourney?['detail']?['depart_time'].split(' ')[0]}   |   ${widget.dataJourney?['detail']?['depart_time'].split(' ')[1].split(':')[0]}:${widget.dataJourney?['detail']?['depart_time'].split(' ')[1].split(':')[1]}"),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Harga",
                  style: Styles.headLineStyle2.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Pergi",
                  style: Styles.headLineStyle3.copyWith(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Penumpang x" +
                        widget.dataJourney!["data"]["passengerCount"]
                            .toString()),
                    Text(NumberFormat.currency(
                            locale: "id", symbol: "Rp. ", decimalDigits: 0)
                        .format((int.parse(
                                widget.dataJourney?["data"]["passengerCount"]) *
                            int.parse(train_fare)))
                        .toString())
                  ],
                ),
                Divider(
                  color: Colors.grey.shade600,
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Pembayaran",
                      style: Styles.headLineStyle1
                          .copyWith(color: Colors.black, fontSize: 15),
                    ),
                    Text(
                      NumberFormat.currency(
                              locale: "id", symbol: "Rp. ", decimalDigits: 0)
                          .format((int.parse(widget.dataJourney?["data"]
                                  ["passengerCount"]) *
                              int.parse(train_fare)))
                          .toString(),
                      style: Styles.headLineStyle1
                          .copyWith(color: Styles.primaryBold, fontSize: 18),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              if (selectedClassData == null) {
                setState(() {
                  _validate = true;
                });
              }

              if (int.parse(widget.dataJourney?["data"]?["passengerCount"]) >
                  selectedClassData?["wagon"]?["wagon_seat"].length) {
                setState(() {
                  _validate = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Kursi tidak cukup!"),
                  backgroundColor: Colors.red,
                ));
              }

              if (_validate == false || selectedClassData.length > 0) {
                widget.dataJourney?["data"]["totalPay"] =
                    (int.parse(widget.dataJourney?["data"]["passengerCount"]) *
                            int.parse(train_fare))
                        .toString();
                widget.dataJourney?["data"]?["class_selected"] =
                    selectedClassData?["class"];

                goPush(BookSeat(widget.dataJourney), context);
              }
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Styles.primaryBold,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text(
                "Pilih Kursi",
                style: Styles.headLineStyle3.copyWith(color: Colors.white),
              )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ]),
      )),
    );
  }
}
