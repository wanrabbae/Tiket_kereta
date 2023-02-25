import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Dio dio = Dio();

String? token;

String endpoint = "https://caleg2024.online/api";
String endpointIP = "http://192.168.1.42:8000/api";

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

double width = MediaQuery.of(navigatorKey.currentContext!).size.width;

double height = MediaQuery.of(navigatorKey.currentContext!).size.height;

var newsDetail = {};
