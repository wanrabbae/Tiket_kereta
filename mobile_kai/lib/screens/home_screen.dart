import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:kai_mobile/core/provider/HomeProvider.dart';
import 'package:kai_mobile/core/utils/constant.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/core/utils/session_manager.dart';
import 'package:kai_mobile/screens/news_screen.dart';
import 'package:kai_mobile/screens/ticket_list.dart';
import 'package:kai_mobile/screens/ticket_view.dart';
import 'package:kai_mobile/utils/app_info_list.dart';
import 'package:kai_mobile/utils/app_layout.dart';
import 'package:kai_mobile/utils/app_styles.dart';
import 'package:kai_mobile/widgets/view_all_widget.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var from = null;
  var to = null;
  final passengerCount = TextEditingController(text: null);
  final departDate = TextEditingController(text: null);
  bool _validate = false;
  String _name = "Guest";

  Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString("name").toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (context, homeProv, _) {
          return homeProv.isLoading == true
              ? Center(
                  child: Lottie.network(loading),
                )
              : Scaffold(
                  backgroundColor: Styles.bgColor,
                  body: SafeArea(
                    child: ListView(
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Styles.primaryBold,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Column(children: [
                                const Gap(40),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Selamat Pagi,",
                                          style: Styles.headLineStyle3
                                              .copyWith(color: Colors.white),
                                        ),
                                        const Gap(5),
                                        Text(
                                          _name == 'null'
                                              ? "Guest"
                                              : _name.split(" ")[0],
                                          style: Styles.headLineStyle1
                                              .copyWith(color: Colors.white),
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/images/img_1.png"))),
                                    )
                                  ],
                                ),
                                const Gap(60),
                              ]),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 120),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                // margin: EdgeInsets.only(top: -100),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DropdownSearch<dynamic>(
                                        popupProps: PopupProps.menu(),
                                        items: homeProv.stationData,
                                        dropdownDecoratorProps:
                                            DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                                  hintText: "Penjemputan",
                                                  errorText: _validate
                                                      ? 'Wajib diisi!'
                                                      : null,
                                                  prefixIcon: Icon(
                                                    Icons.departure_board,
                                                    color: Styles.primaryBold,
                                                  )),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            from = value;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      DropdownSearch<dynamic>(
                                        popupProps: PopupProps.menu(),
                                        items: homeProv.stationData,
                                        dropdownDecoratorProps:
                                            DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                                  hintText: "Destinasi",
                                                  errorText: _validate
                                                      ? 'Wajib diisi!'
                                                      : null,
                                                  prefixIcon: Icon(
                                                    Icons.train_sharp,
                                                    color: Styles.primaryBold,
                                                  )),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            to = value;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: passengerCount,
                                        decoration: InputDecoration(
                                            hintText: "Jumlah Penumpang",
                                            errorText: _validate
                                                ? 'Wajib diisi!'
                                                : null,
                                            prefixIcon: Icon(
                                              Icons.person_add_alt_rounded,
                                              color: Styles.primaryBold,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: departDate,
                                        onTap: () {
                                          DatePicker.showDatePicker(context,
                                              showTitleActions: true,
                                              onChanged: (date) {
                                            print('change $date');
                                          }, onConfirm: (date) {
                                            setState(() {
                                              departDate.text =
                                                  date.toString().split(" ")[0];
                                            });
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.id);
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Tanggal Berangkat",
                                            errorText: _validate
                                                ? 'Wajib diisi!'
                                                : null,
                                            prefixIcon: Icon(
                                              Icons.date_range,
                                              color: Styles.primaryBold,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            from == null
                                                ? _validate = true
                                                : _validate = false;
                                            to == null
                                                ? _validate = true
                                                : _validate = false;
                                            passengerCount.text.isEmpty
                                                ? _validate = true
                                                : _validate = false;
                                            departDate.text.isEmpty
                                                ? _validate = true
                                                : _validate = false;
                                          });

                                          if (_validate == false) {
                                            var data = {
                                              "from":
                                                  from.toString().split("(")[0],
                                              "to": to.toString().split("(")[0],
                                              "passengerCount":
                                                  passengerCount.text,
                                              "departTime": departDate.text,
                                            };

                                            var res =
                                                await homeProv.getTickets(data);

                                            goPush(TicketList(res));
                                          }
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    AppLayout.getHeight(18),
                                                horizontal:
                                                    AppLayout.getWidth(15)),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppLayout.getWidth(10)),
                                                color: Styles.primaryBold),
                                            child: Center(
                                              child: Text(
                                                "Cari Tiket",
                                                style: Styles.textStyle
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(25),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Berita Terbaru',
                            style: Styles.headLineStyle2,
                          ),
                        ),
                        const Gap(5),
                        SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                                children: homeProv.newsData
                                    .map((hotelInfo) =>
                                        NewsList(hotel: hotelInfo))
                                    .toList()))
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
