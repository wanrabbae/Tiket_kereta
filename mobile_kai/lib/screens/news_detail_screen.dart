import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kai_mobile/core/utils/constant.dart';
import 'package:kai_mobile/utils/app_styles.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsDetail["title"].toString()),
        backgroundColor: Styles.primaryBold,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Image.network(newsDetail["image"].toString()),
                ),
                SizedBox(
                  height: 10,
                  child: Text(
                    newsDetail["published_at"].toString(),
                    style: Styles.headLineStyle4
                        .copyWith(color: Colors.grey[400], fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Html(data: newsDetail["description"].toString())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
