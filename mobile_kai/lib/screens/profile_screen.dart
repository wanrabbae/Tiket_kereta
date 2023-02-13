import 'package:kai_mobile/utils/app_layout.dart';
import 'package:kai_mobile/utils/app_styles.dart';
import 'package:kai_mobile/widgets/layout_builder_widget.dart';
import 'package:kai_mobile/widgets/paired_column_widget.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// class ProfileScreen extends StatelessWidget {

//   final String? fullName;
//   final String? email;
//   final String? identity;

//   ProfileScreen({this.fullName, this.email, this.identity});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 140,
//               height: 140,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                   image: NetworkImage("https://picsum.photos/200"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               fullName!,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               email!,
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               identity!,
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//             SizedBox(height: 20),
//             TextButton(
//               onPressed: () {},
//               child: Text(
//                 "Edit Profile",
//                 style: TextStyle(
//                   color: Colors.blue,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.bgColor,
        body: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: AppLayout.getWidth(20),
                vertical: AppLayout.getHeight(20)),
            children: [
              Gap(AppLayout.getHeight(60)),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                    width: AppLayout.getWidth(86),
                    height: AppLayout.getHeight(86),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppLayout.getHeight(10)),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/img_1.png")))),
                Gap(AppLayout.getHeight(10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Alwan",
                      style: Styles.headLineStyle1,
                    ),
                    Gap(AppLayout.getHeight(2)),
                    Text(
                      "Alwan",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade500),
                    ),
                    Gap(AppLayout.getHeight(8)),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppLayout.getWidth(3),
                          vertical: AppLayout.getHeight(3)),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppLayout.getWidth(100)),
                          color: const Color(0xFFFEF4F3)),
                      child: Row(
                        children: [],
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => print("tapped"),
                      child: Text("Edit",
                          style: Styles.textStyle.copyWith(
                              color: Styles.primaryColor,
                              fontWeight: FontWeight.w300)),
                    )
                  ],
                )
              ]),
              Gap(AppLayout.getHeight(8)),
              Divider(
                color: Colors.grey.shade300,
              ),
              Gap(AppLayout.getHeight(25)),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: AppLayout.getWidth(10)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppLayout.getWidth(18)),
                    color: Styles.bgColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 1,
                          spreadRadius: 2)
                    ]),
                child: Column(children: [
                  Gap(AppLayout.getHeight(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Miles accrued",
                        style: Styles.headLineStyle4.copyWith(fontSize: 16),
                      ),
                      Text(
                        "16 DEC 2022",
                        style: Styles.headLineStyle4.copyWith(fontSize: 16),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  Gap(AppLayout.getHeight(4)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      PairedColumnWidget(
                        firstText: "23 042",
                        secondText: "Miles",
                        alignment: CrossAxisAlignment.start,
                        isColor: false,
                      ),
                      PairedColumnWidget(
                        firstText: "Airline Co",
                        secondText: "Received From",
                        alignment: CrossAxisAlignment.end,
                        isColor: false,
                      )
                    ],
                  ),
                  Gap(AppLayout.getHeight(12)),
                  const LayoutBuilderWidget(
                    sections: 6,
                    isColor: false,
                  ),
                  Gap(AppLayout.getHeight(12)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      PairedColumnWidget(
                        firstText: "24",
                        secondText: "Miles",
                        alignment: CrossAxisAlignment.start,
                        isColor: false,
                      ),
                      PairedColumnWidget(
                        firstText: "Mc Donald's",
                        secondText: "Received From",
                        alignment: CrossAxisAlignment.end,
                        isColor: false,
                      )
                    ],
                  ),
                  Gap(AppLayout.getHeight(12)),
                  const LayoutBuilderWidget(
                    sections: 6,
                    isColor: false,
                  ),
                  Gap(AppLayout.getHeight(12)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      PairedColumnWidget(
                        firstText: "52 340",
                        secondText: "Miles",
                        alignment: CrossAxisAlignment.start,
                        isColor: false,
                      ),
                      PairedColumnWidget(
                        firstText: "NatraTek",
                        secondText: "Received From",
                        alignment: CrossAxisAlignment.end,
                        isColor: false,
                      )
                    ],
                  ),
                ]),
              ),
              Gap(AppLayout.getHeight(25)),
              InkWell(
                onTap: () {
                  print("tapped");
                },
                child: Center(
                  child: Text("How to get more miles?",
                      style: Styles.textStyle.copyWith(
                        color: Styles.primaryColor,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              )
            ]));
  }
}
