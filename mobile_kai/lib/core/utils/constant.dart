import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Dio dio = Dio();

String? token;

String endpoint = "";
String endpointIP = "http://192.168.1.104:8000/api";

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
