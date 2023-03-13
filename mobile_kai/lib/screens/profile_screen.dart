import 'dart:ffi';
import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:kai_mobile/core/provider/AuthProvider.dart';
import 'package:kai_mobile/core/utils/constant.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/core/utils/session_manager.dart';
import 'package:kai_mobile/screens/bottom_bar.dart';
import 'package:kai_mobile/utils/app_layout.dart';
import 'package:kai_mobile/utils/app_styles.dart';
import 'package:kai_mobile/widgets/layout_builder_widget.dart';
import 'package:kai_mobile/widgets/paired_column_widget.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEdit = false;
  bool _isObscure2 = true;

  bool _isObscure = true;
  bool _tokened = false;
  bool _validate = false;

  Map errorObject = {
    "id": ["Wajib diisi!"],
    "email": ["Wajib diisi!"],
    "password": ["Wajib diisi!"],
    "country": ["Wajib diisi!"],
    "city": ["Wajib diisi!"],
    "name": ["Wajib diisi!"],
  };

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController ktpCtrl2 = TextEditingController();
  TextEditingController namaCtrl2 = TextEditingController();
  TextEditingController countryCtrl2 = TextEditingController();
  TextEditingController cityCtrl2 = TextEditingController();

  Future<String?> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token") != null) {
      setState(() {
        _tokened = true;
      });
    } else {
      setState(() {
        _tokened = false;
      });
    }
  }

  randomNumber() {
    var rng = Random();
    return rng.nextInt(100000);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AuthProvider(),
        child: Consumer<AuthProvider>(
          builder: (context, authProv, child) {
            String joined = DateFormat.yMMMd()
                .format(DateTime.parse(authProv.userData["created_at"] ??
                    DateTime.now().toString()))
                .toString();

            TextEditingController namaCtrl = TextEditingController(
                text: authProv.userData["name"].toString() == 'null'
                    ? 'Name'
                    : authProv.userData["name"].toString());
            TextEditingController emailCtrl = TextEditingController(
                text: authProv.userData["email"].toString() == 'null'
                    ? 'Email'
                    : authProv.userData["email"].toString());
            TextEditingController countryCtrl = TextEditingController(
                text: authProv.userData["country"].toString() == 'null'
                    ? 'Country'
                    : authProv.userData["country"].toString());
            TextEditingController cityCtrl = TextEditingController(
                text: authProv.userData["city"].toString() == 'null'
                    ? 'City'
                    : authProv.userData["city"].toString());

            return Scaffold(
              backgroundColor: Styles.bgColor,
              body: _tokened
                  ? !authProv.isLoading
                      ? ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppLayout.getWidth(20),
                              vertical: AppLayout.getHeight(20)),
                          children: [
                              Gap(AppLayout.getHeight(60)),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: AppLayout.getWidth(86),
                                        height: AppLayout.getHeight(86),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                AppLayout.getHeight(10)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://api.multiavatar.com/Binx Bond${randomNumber()}.png")))),
                                    Gap(AppLayout.getHeight(10)),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          authProv.userData["name"]
                                                  .split(" ")[0] ??
                                              "Guest yeyee",
                                          style: Styles.headLineStyle1,
                                        ),
                                        Gap(AppLayout.getHeight(2)),
                                        Container(
                                          width: 170,
                                          child: Text(
                                            authProv.userData["name"] ??
                                                "Guest Yeyy",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey.shade500),
                                          ),
                                        ),
                                        Gap(AppLayout.getHeight(8)),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: AppLayout.getWidth(3),
                                              vertical: AppLayout.getHeight(3)),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppLayout.getWidth(100)),
                                              color: const Color(0xFFFEF4F3)),
                                          child: Row(
                                            children: [],
                                          ),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () => setState(() {
                                            isEdit = !isEdit;
                                          }),
                                          child: Text("Edit",
                                              style: Styles.textStyle.copyWith(
                                                  color: Styles.primaryColor,
                                                  fontWeight: FontWeight.w300)),
                                        )
                                      ],
                                    )
                                  ]),
                              Divider(
                                color: Colors.grey.shade300,
                              ),
                              isEdit
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          controller: namaCtrl,
                                          decoration: InputDecoration(
                                              hintText: "Nama Lengkap",
                                              prefixIcon: Icon(
                                                FluentSystemIcons
                                                    .ic_fluent_person_accounts_regular,
                                                color: Styles.primaryBold,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: emailCtrl,
                                          decoration: InputDecoration(
                                              hintText: "E-mail",
                                              prefixIcon: Icon(
                                                Icons.email,
                                                color: Styles.primaryBold,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: countryCtrl,
                                          decoration: InputDecoration(
                                              hintText: "Negara",
                                              prefixIcon: Icon(
                                                FluentSystemIcons
                                                    .ic_fluent_flag_filled,
                                                color: Styles.primaryBold,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: cityCtrl,
                                          decoration: InputDecoration(
                                              hintText: "Kota / Kabupaten",
                                              prefixIcon: Icon(
                                                FluentSystemIcons
                                                    .ic_fluent_city_regular,
                                                color: Styles.primaryBold,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await authProv.updateProfile({
                                              "name": namaCtrl.text,
                                              "email": emailCtrl.text,
                                              "city": cityCtrl.text,
                                              "country": countryCtrl.text
                                            });
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
                                                          AppLayout.getWidth(
                                                              10)),
                                                  color: Styles.primaryBold),
                                              child: Center(
                                                child: Text(
                                                  "Simpan",
                                                  style: Styles.textStyle
                                                      .copyWith(
                                                          color: Colors.white),
                                                ),
                                              )),
                                        ),
                                      ],
                                    )
                                  : Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AppLayout.getWidth(10)),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppLayout.getWidth(18)),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Joined",
                                              style: Styles.headLineStyle4
                                                  .copyWith(fontSize: 16),
                                            ),
                                            Text(
                                              joined.toString(),
                                              style: Styles.headLineStyle4
                                                  .copyWith(fontSize: 16),
                                            )
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.grey.shade300,
                                        ),
                                        Gap(AppLayout.getHeight(4)),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            PairedColumnWidget(
                                              firstText: authProv
                                                          .userData["name"]
                                                          .toString() ==
                                                      'null'
                                                  ? 'Name'
                                                  : authProv.userData["name"]
                                                      .toString(),
                                              secondText: "Nama Lengkap",
                                              alignment:
                                                  CrossAxisAlignment.start,
                                              isColor: false,
                                            ),
                                          ],
                                        ),
                                        Gap(AppLayout.getHeight(12)),
                                        const LayoutBuilderWidget(
                                          sections: 6,
                                          isColor: false,
                                        ),
                                        Gap(AppLayout.getHeight(12)),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            PairedColumnWidget(
                                              firstText: authProv
                                                          .userData["email"]
                                                          .toString() ==
                                                      'null'
                                                  ? 'Email'
                                                  : authProv.userData["email"]
                                                      .toString(),
                                              secondText: "E-mail",
                                              alignment:
                                                  CrossAxisAlignment.start,
                                              isColor: false,
                                            ),
                                          ],
                                        ),
                                        Gap(AppLayout.getHeight(12)),
                                        const LayoutBuilderWidget(
                                          sections: 6,
                                          isColor: false,
                                        ),
                                        Gap(AppLayout.getHeight(12)),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            PairedColumnWidget(
                                              firstText: authProv
                                                          .userData["country"]
                                                          .toString() ==
                                                      'null'
                                                  ? 'Country'
                                                  : authProv.userData["country"]
                                                      .toString(),
                                              secondText: "Negara",
                                              alignment:
                                                  CrossAxisAlignment.start,
                                              isColor: false,
                                            ),
                                          ],
                                        ),
                                        Gap(AppLayout.getHeight(12)),
                                        const LayoutBuilderWidget(
                                          sections: 6,
                                          isColor: false,
                                        ),
                                        Gap(AppLayout.getHeight(12)),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            PairedColumnWidget(
                                              firstText: authProv
                                                          .userData["city"]
                                                          .toString() ==
                                                      'null'
                                                  ? 'City'
                                                  : authProv.userData["city"]
                                                      .toString(),
                                              secondText: "Kota / Kabupaten",
                                              alignment:
                                                  CrossAxisAlignment.start,
                                              isColor: false,
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ),
                              Gap(AppLayout.getHeight(25)),
                              InkWell(
                                onTap: () {
                                  SessionManager.clearSession();
                                  goRemove(BottomBar(0));
                                },
                                child: Center(
                                  child: Text("Logout",
                                      style: Styles.textStyle.copyWith(
                                        color: Styles.primaryColor,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ),
                              )
                            ])
                      : Center(
                          child: CircularProgressIndicator(),
                        )
                  // ====== LOGIN PAGE =====
                  : isLogged
                      ? SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 50),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Image.network(
                                      "https://i.ibb.co/jDwfZZ3/undraw-two-factor-authentication-namy-removebg-preview.png",
                                      fit: BoxFit.contain,
                                      height: 350.0,
                                      width: 350.0,
                                    )),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: TextFormField(
                                          controller: emailController,
                                          style: TextStyle(fontSize: 12),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10),
                                            hintText: "Masukkan Email",
                                            prefixIcon: Icon(
                                              PhosphorIcons.userCircleBold,
                                              size: 30,
                                              color: Colors.grey.shade400,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                                borderSide: BorderSide(
                                                    color: Colors.grey.shade400,
                                                    width: 2.0)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                                borderSide: BorderSide(
                                                    color: Colors.grey.shade400,
                                                    width: 2.0)),
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: TextFormField(
                                          controller: passwordController,
                                          style: TextStyle(fontSize: 12),
                                          obscureText: _isObscure,
                                          enableSuggestions: false,
                                          autocorrect: false,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10),
                                            hintText: "Masukkan Password",
                                            prefixIcon: Icon(
                                              PhosphorIcons.lockBold,
                                              size: 30,
                                              color: Colors.grey.shade400,
                                            ),
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _isObscure = !_isObscure;
                                                  });
                                                },
                                                icon: Icon(
                                                  _isObscure
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Colors.grey.shade400,
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                                borderSide: BorderSide(
                                                    color: Colors.grey.shade400,
                                                    width: 2.0)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                                borderSide: BorderSide(
                                                    color: Colors.grey.shade400,
                                                    width: 2.0)),
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: SizedBox(
                                    width: EdgeInsets.symmetric(horizontal: 60)
                                        .horizontal,
                                    child: TextButton(
                                      onPressed: () async {
                                        Map<String, dynamic> requestBody = {
                                          'email': emailController.text,
                                          'password': passwordController.text
                                        };
                                        await authProv.login(requestBody);
                                      },
                                      child: authProv.isLoading == true
                                          ? CircularProgressIndicator()
                                          : Text(
                                              "Masuk",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.all(10),
                                        backgroundColor: Styles.primaryBold,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isLogged = false;
                                      });
                                    },
                                    child: Text(
                                      "Daftar",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Container(
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 50),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Image.network(
                                    "https://i.ibb.co/vJqXLxs/undraw-mobile-ux-re-59hr-removebg-preview.png",
                                    fit: BoxFit.contain,
                                    height: 250.0,
                                    width: 250.0,
                                  )),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: TextFormField(
                                        controller: ktpCtrl2,
                                        style: TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          hintText: "No. KTP",
                                          errorText: _validate
                                              ? errorObject["id"][0]
                                              : null,
                                          prefixIcon: Icon(
                                            PhosphorIcons.userCircleBold,
                                            size: 30,
                                            color: Colors.grey.shade400,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                  width: 2.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                  width: 2.0)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                  width: 2.0)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.grey.shade400,
                                                      width: 2.0)),
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: TextFormField(
                                        controller: namaCtrl2,
                                        style: TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          hintText: "Nama Lengkap",
                                          errorText: _validate
                                              ? errorObject["name"][0]
                                              : null,
                                          prefixIcon: Icon(
                                            PhosphorIcons.userCircleBold,
                                            size: 30,
                                            color: Colors.grey.shade400,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                  width: 2.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                  width: 2.0)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                  width: 2.0)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.grey.shade400,
                                                      width: 2.0)),
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: DropdownSearch<String>(
                                        popupProps: PopupProps.dialog(),
                                        items: ["Indonesia", "Malaysia"],
                                        dropdownDecoratorProps:
                                            DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            hintStyle: TextStyle(fontSize: 12),
                                            errorText: _validate
                                                ? errorObject["country"][0]
                                                : null,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10),
                                            hintText: "Pilih Negara",
                                            prefixIcon: Icon(
                                                PhosphorIcons.globeBold,
                                                color: Colors.grey.shade400),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                                borderSide: BorderSide(
                                                    color: Colors.grey.shade400,
                                                    width: 2.0)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                                borderSide: BorderSide(
                                                    color: Colors.grey.shade400,
                                                    width: 2.0)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                                borderSide: BorderSide(
                                                    color: Colors.grey.shade400,
                                                    width: 2.0)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade400,
                                                        width: 2.0)),
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            countryCtrl2.text =
                                                value.toString();
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: DropdownSearch<String>(
                                        popupProps: PopupProps.dialog(),
                                        items: ["Jakarta", "Kuala Lumpur"],
                                        dropdownDecoratorProps:
                                            DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            hintStyle: TextStyle(fontSize: 12),
                                            errorText: _validate
                                                ? errorObject["city"][0]
                                                : null,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10),
                                            hintText: "Pilih Kota",
                                            prefixIcon: Icon(
                                                PhosphorIcons.globeBold,
                                                color: Colors.grey.shade400),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                                borderSide: BorderSide(
                                                    color: Colors.grey.shade400,
                                                    width: 2.0)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                                borderSide: BorderSide(
                                                    color: Colors.grey.shade400,
                                                    width: 2.0)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                                borderSide: BorderSide(
                                                    color: Colors.grey.shade400,
                                                    width: 2.0)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade400,
                                                        width: 2.0)),
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            cityCtrl2.text = value.toString();
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: TextFormField(
                                        controller: emailController,
                                        style: TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          hintText: "Masukkan Email",
                                          errorText: _validate
                                              ? errorObject["email"][0]
                                              : null,
                                          prefixIcon: Icon(
                                            PhosphorIcons.envelope,
                                            size: 30,
                                            color: Colors.grey.shade400,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                  width: 2.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                  width: 2.0)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                  width: 2.0)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.grey.shade400,
                                                      width: 2.0)),
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: TextFormField(
                                        controller: passwordController,
                                        style: TextStyle(fontSize: 12),
                                        obscureText: _isObscure,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          hintText: "Masukkan Password",
                                          errorText: _validate
                                              ? errorObject["password"][0]
                                              : null,
                                          prefixIcon: Icon(
                                            PhosphorIcons.lockBold,
                                            size: 30,
                                            color: Colors.grey.shade400,
                                          ),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _isObscure = !_isObscure;
                                                });
                                              },
                                              icon: Icon(
                                                _isObscure
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.grey.shade400,
                                              )),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                  width: 2.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                  width: 2.0)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                  width: 2.0)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.grey.shade400,
                                                      width: 2.0)),
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: TextFormField(
                                        controller: confirmPasswordController,
                                        style: TextStyle(fontSize: 12),
                                        obscureText: _isObscure2,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          hintText: "Konfirmasi Password",
                                          errorText: _validate
                                              ? errorObject["password"][0]
                                              : null,
                                          prefixIcon: Icon(
                                            PhosphorIcons.lockBold,
                                            size: 30,
                                            color: Colors.grey.shade400,
                                          ),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _isObscure2 = !_isObscure2;
                                                });
                                              },
                                              icon: Icon(
                                                _isObscure2
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.grey.shade400,
                                              )),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                  width: 2.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                  width: 2.0)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                  width: 2.0)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.grey.shade400,
                                                      width: 2.0)),
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: SizedBox(
                                  width: EdgeInsets.symmetric(horizontal: 60)
                                      .horizontal,
                                  child: TextButton(
                                    onPressed: () async {
                                      setState(() {
                                        ktpCtrl2.text.isEmpty
                                            ? _validate = true
                                            : _validate = false;
                                        namaCtrl2.text.isEmpty
                                            ? _validate = true
                                            : _validate = false;
                                        emailController.text.isEmpty
                                            ? _validate = true
                                            : _validate = false;
                                        cityCtrl2.text.isEmpty
                                            ? _validate = true
                                            : _validate = false;
                                        countryCtrl2.text.isEmpty
                                            ? _validate = true
                                            : _validate = false;
                                        passwordController.text.isEmpty
                                            ? _validate = true
                                            : _validate = false;
                                        confirmPasswordController.text.isEmpty
                                            ? _validate = true
                                            : _validate = false;
                                      });

                                      var data = {
                                        "id": ktpCtrl2.text,
                                        "name": namaCtrl2.text,
                                        "email": emailController.text,
                                        "city": cityCtrl2.text,
                                        "country": countryCtrl2.text,
                                        "password": passwordController.text,
                                        "password_confirmation":
                                            confirmPasswordController.text
                                      };
                                      if (_validate == false) {
                                        await authProv.register(data);
                                      }
                                    },
                                    child: Text(
                                      "Daftar",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.all(10),
                                      backgroundColor: Styles.primaryBold,
                                    ),
                                  ),
                                ),
                              ),
                              Consumer<AuthProvider>(
                                  builder: (context, value, child) {
                                return Container(
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isLogged = true;
                                      });
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        )),
            );
          },
        ));
  }
}
