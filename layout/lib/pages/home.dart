import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onPressed() {
    print('ok');
  }

  Future getData() async {
    final res;
    var url =
        Uri.parse('https://raw.githubusercontent.com/sit1977/Flutter2MobileAppBootcamp/main/layout/assets/data.json');
    res = await http.get(url);
    if (res.statusCode == 200) {
      // var data = json.decode(res.body.toString());
      return json.decode(res.body.toString());
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "ดอกไม้น่าปลูก",
          style: TextStyle(
            //color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.black, offset: Offset(1, 2))],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //var data = json.decode(snapshot.data.toString());
              var data = snapshot.data;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return myCard(_size, data[index]['title'], data[index]['title1'], data[index]['detail'],
                        data[index]['image']);
                  });
            } else {
              return CircularProgressIndicator();
            }
          },
          //future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
          future: getData(),
        ),
      ),
    );
  }

  Widget myCard(Size _size, String title, String title1, String detail, String pathimage) {
    return Container(
      margin: EdgeInsets.all(8),
      //padding: EdgeInsets.all(8),
      height: _size.height * 0.25,
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.fitWidth,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
              //image: AssetImage('assets/images/$pathimage')
              image: NetworkImage(pathimage)),
          boxShadow: [BoxShadow(offset: Offset(0, 2), blurRadius: 5, color: Colors.black.withOpacity(0.5))],
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      shadows: [Shadow(color: Colors.black, offset: Offset(1, 2))],
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: _size.height * 0.04),
                ),
                Text(
                  '$title1',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      //shadows: [Shadow(color: Colors.black, offset: Offset(1, 2))],
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: _size.height * 0.02),
                ),
                /*Container(
                  color: Colors.grey,
                  height: 2,
                ),*/
              ],
            ),
            Text(
              '$detail',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: _size.height * 0.03),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                    title: title,
                                    title1: title1,
                                    detail: detail,
                                    image: pathimage,
                                  )));
                    },
                    child: Text(
                      'อ่านต่อ',
                      style: TextStyle(color: Colors.yellow),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
