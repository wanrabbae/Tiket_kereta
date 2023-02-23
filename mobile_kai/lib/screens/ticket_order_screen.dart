import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/utils/app_styles.dart';

class TicketOrder extends StatefulWidget {
  final Map? dataJourney;
  const TicketOrder(@required this.dataJourney);

  @override
  State<TicketOrder> createState() => _TicketOrderState();
}

class _TicketOrderState extends State<TicketOrder> {
  List<Widget> getInputPsg() {
    List<Widget> childs = [];
    for (var i = 1;
        i < int.parse(widget.dataJourney?["passengerCount"]) + 1;
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
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Styles.primaryBold, width: 1.5)),
                enabledBorder: OutlineInputBorder(
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
          TextFormField(
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Styles.primaryBold, width: 1.5)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Styles.primaryBold, width: 1.5)),
                hintText: "Title",
                prefixIcon: Icon(
                  FluentSystemIcons.ic_fluent_app_title_regular,
                  color: Styles.primaryBold,
                )),
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

  @override
  Widget build(BuildContext context) {
    print(widget.dataJourney);
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
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: getInputPsg(),
            ),
          )
        ]),
      )),
    );
  }
}
