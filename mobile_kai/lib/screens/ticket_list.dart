import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/screens/ticket_order_screen.dart';
import 'package:kai_mobile/utils/app_styles.dart';

class TicketList extends StatefulWidget {
  final Map? dataJourney;
  const TicketList(@required this.dataJourney);

  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  List<Widget> getClass(data) {
    List<Widget> childs = [];
    for (var i = 0; i < data.length; i++) {
      var data2 = data[i];
      childs.add(new Text(
        "${data2['class']} / ".toUpperCase(),
        style: Styles.headLineStyle4
            .copyWith(color: Colors.grey.shade500, fontSize: 13),
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
            child: ListView.builder(
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
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(7.0),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: getClass(ticket["train_fare"]),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "tersisa 2 kursi",
                                      style: Styles.headLineStyle4.copyWith(
                                          color: Colors.red.shade600,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Rp. 280.000",
                                      style: Styles.headLineStyle3
                                          .copyWith(color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Styles.primaryBold),
                                        ),
                                        onPressed: () {
                                          widget.dataJourney?["data"]["price"] =
                                              "280000";
                                          goPush(
                                              TicketOrder({
                                                "data":
                                                    widget.dataJourney?["data"],
                                                "detail": ticket
                                              }),
                                              context);
                                        },
                                        child: Text(
                                          'Pilih',
                                          style: Styles.headLineStyle3.copyWith(
                                              color: Colors.white,
                                              fontSize: 16),
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                );
              },
            )));
  }
}
