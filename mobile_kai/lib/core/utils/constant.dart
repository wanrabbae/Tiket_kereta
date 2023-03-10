import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Dio dio = Dio();

// String? token = "5|e36ttRpoIqcPTdi8iaJlRiL1hhwm2fI36O47XR3A";
String? token;
String? nama;

bool isLogged = true;

String endpoint = "";
// String endpointIP = "http://192.168.100.119:8000/api"; // rumah
String endpointIP = "http://192.168.142.31:8000/api"; // alwan
// String endpointIP = "http://40.40.43.225:8000/api"; // lab mm
// String endpointIP = "http://192.168.211.31:8000/api"; // ibnu

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

double width = MediaQuery.of(navigatorKey.currentContext!).size.width;

double height = MediaQuery.of(navigatorKey.currentContext!).size.height;
String loading =
    "https://assets6.lottiefiles.com/datafiles/bNwYPnjv3OdFA5w/data.json";
var newsDetail = {};

const kElevation = 1.0;
const kTiny = 2.0;
const kSmall = 4.0;
const kMedium = 8.0;
const kLarge = 16.0;
