import 'dart:ui';

import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  //const DetailPage({Key? key}) : super(key: key);
  final String title, title1, detail, image;
  DetailPage({required this.title, required this.title1, required this.detail, required this.image});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('รายละเอียด'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: _size.height * 0.05),
                ),
              ),
              Text(
                title1,
                style: TextStyle(fontSize: _size.height * 0.03),
              ),
              SizedBox(
                height: _size.height * 0.02,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image(image: AssetImage('assets/images/' + image)),
              ),
              SizedBox(
                height: _size.height * 0.02,
              ),
              Text(
                detail,
                style: TextStyle(fontSize: _size.height * 0.03),
              )
            ],
          ),
        ),
      ),
    );
  }
}
