import 'package:assessment_in/pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future<List> fetchCountry() async {
  final response = await http.get(
      Uri.https('vipankumar.com', '/SmartHealth/api/getCountries'),
      headers: {"Accept": "application/json"});
  var convertDataToJson = jsonDecode(response.body);
  // print(convertDataToJson['data']['countries']);
  return convertDataToJson['data']['countries'];
}

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
            child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "images/arrow.svg",
                  width: 18,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'Select Country',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2A2A2A),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 17),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFF70707033), width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                leading: Icon(Icons.search),
                title: TextField(
                  controller: _textEditingController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                  ),
                ),
              ),
            ),
            Container(
              child: FutureBuilder(
                  future: fetchCountry(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map country = snapshot.data[index];
                          return ListTile(
                            title: Text(
                              'Search',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF757575),
                              ),
                            ),
                            onTap: () {
                              Get.to(HomePage());
                            },
                          );
                        },
                      );
                    } else {
                      return Text("Can't fetch data");
                    }
                  }),
            ),
          ],
        )),
      ),
    );
  }
}
