import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:kai_mobile/core/utils/constant.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/screens/ticket_order_screen.dart';
import 'package:kai_mobile/utils/app_styles.dart';
import 'package:lottie/lottie.dart';

class TicketList extends StatefulWidget {
  final Map? dataJourney;
  const TicketList(@required this.dataJourney);

  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  final oCcy = new NumberFormat("#.##", "id_IDR");
  List<Widget> getClass(data) {
    List<Widget> childs = [];
    for (var i = 0; i < data.length; i++) {
      var data2 = data[i];
      childs.add(Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${data2['class']}".toUpperCase(),
                  style: Styles.headLineStyle4
                      .copyWith(color: Colors.grey.shade500, fontSize: 15),
                ),
                Text(
                  "sisa " +
                      (data2?["wagon"]?["wagon_seat"].length).toString() +
                      " kursi",
                  style: TextStyle(
                      fontSize: 10,
                      color: data2?["wagon"]?["wagon_seat"].length < 10
                          ? Colors.red
                          : Colors.green),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  NumberFormat.currency(
                          locale: "id", symbol: "Rp. ", decimalDigits: 0)
                      .format(data2["fare"])
                      .toString(),
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Divider(height: 0, color: Colors.grey.shade600),
          ],
        ),
      ));
    }
    return childs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.primaryBold,
          title: RichText(
            text: TextSpan(
              text: '${widget.dataJourney?["data"]['from']} ',
              style: Styles.headLineStyle2
                  .copyWith(color: Colors.white, fontSize: 15),
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.arrow_right_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                TextSpan(text: ' ${widget.dataJourney?["data"]['to']}'),
              ],
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
            child: widget.dataJourney?["response"].length > 0
                ? ListView.builder(
                    itemCount: widget.dataJourney?["response"].length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var ticket = widget.dataJourney?["response"][index];
                      return GestureDetector(
                        onTap: () {
                          print("TEST ${index}");
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            bottom: 10,
                            left: 7,
                            right: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ticket["train"]["train_name"].toString(),
                                    style: Styles.headLineStyle3,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Icon(
                                      Icons.train_rounded,
                                      color: Styles.primaryBold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text("12:00",
                                              style: TextStyle(fontSize: 16)),
                                          Text(
                                            "${widget.dataJourney?["data"]['from']}",
                                            style: TextStyle(
                                                color: Colors.grey.shade400,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                      Icon(
                                        Icons.arrow_right_alt,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      Column(
                                        children: [
                                          Text("14:00",
                                              style: TextStyle(fontSize: 16)),
                                          Text(
                                            "${widget.dataJourney?["data"]['to']}",
                                            style: TextStyle(
                                                color: Colors.grey.shade400,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    children: getClass(ticket["train_fare"]),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.start,
                                  //       children: [
                                  //         // SizedBox(
                                  //         //   height: 50,
                                  //         // ),
                                  //         // Text(
                                  //         //   "tersisa 2 kursi",
                                  //         //   style: Styles.headLineStyle4
                                  //         //       .copyWith(
                                  //         //           color: Colors.red.shade600,
                                  //         //           fontWeight:
                                  //         //               FontWeight.bold),
                                  //         // )
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Styles.primaryBold),
                                          ),
                                          onPressed: () {
                                            if (token != null) {
                                              widget.dataJourney?["data"]
                                                  ["price"] = "280000";
                                              goPush(
                                                  TicketOrder({
                                                    "data": widget
                                                        .dataJourney?["data"],
                                                    "detail": ticket
                                                  }),
                                                  context);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Anda harus login terlebih dahulu"),
                                                backgroundColor: Colors.red,
                                              ));
                                            }
                                          },
                                          child: Text(
                                            'Pilih',
                                            style: Styles.headLineStyle3
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                          )),
                                    ],
                                  )
                                ],
                              )),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Lottie.network(
                        "https://assets5.lottiefiles.com/packages/lf20_mkcnkz8c.json",
                        width: 300,
                        height: 300),
                  )));
  }
}
