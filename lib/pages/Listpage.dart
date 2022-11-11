import 'dart:async';

import 'package:assessment_in/pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:assessment_in/controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

Future<List> fetchCountry() async {
  final response = await http.get(
      Uri.parse('https://vipankumar.com/SmartHealth/api/getCountries'),
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
  //variables
  final Controller controller = Get.find();
  var country_selected = false;
  var country_list;
  TextEditingController _textEditingController = TextEditingController();
  String _now = "";
  var _everySecond;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initstate called");

    // Update this screens state every second
    changeStatePerSec();

    // Set country list to country_list variable
    setCountryList();
    print(country_list);

    // Update country list every 10 sec
    changeListItem();
  }

  changeStatePerSec() {
    // sets first value
    _now = DateTime.now().second.toString();

    // defines a timer
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _now = DateTime.now().second.toString();
      });
    });
  }

  changeListItem() {
    // defines a timer
    _everySecond = Timer.periodic(Duration(seconds: 10), (Timer t) {
      setState(() {
        if (country_list != null) {
          if (country_list.length != 0) {
            country_list.removeAt(0);
          } else {
            setCountryList();
          }
        }
      });
    });
  }

  setCountryList() async {
    final response = await http.get(
        Uri.parse('https://vipankumar.com/SmartHealth/api/getCountries'),
        headers: {"Accept": "application/json"});
    var convertDataToJson = jsonDecode(response.body);
    // print(convertDataToJson['data']['countries']);
    country_list = convertDataToJson['data']['countries'];
    print(country_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
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
            Visibility(
              visible: country_selected == true ? true : false,
              child: ListTile(
                leading: Obx(() => CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      foregroundImage:
                          NetworkImage(controller.country_image.string),
                    )),
                title: Obx(() => Text(
                      controller.country_name.string +
                          " (+" +
                          controller.country_code.string +
                          ")",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2A2A2A),
                      ),
                    )),
                trailing: Text(
                  "Selected",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2A2A2A),
                  ),
                ),
                onTap: () {
                  setState(() {
                    this.country_selected = false;
                    print(country_selected);
                  });
                },
              ),
            ),
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height -
                      (country_selected == true ? 230 : 180),
                  child: Expanded(
                    child: country_list != null
                        ? RefreshIndicator(
                            onRefresh: () async {
                              setCountryList();
                            },
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              addAutomaticKeepAlives: true,
                              itemExtent: 60,
                              itemCount: country_list.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map country = country_list[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    foregroundImage:
                                        NetworkImage(country['image']),
                                    onForegroundImageError:
                                        (exception, stackTrace) {
                                      print(exception);
                                    },
                                    backgroundColor: Colors.blueGrey,
                                    child: Icon(Icons.error),
                                  ),
                                  title: Text(
                                    country['country_name'],
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF2A2A2A),
                                    ),
                                  ),
                                  trailing: Text(
                                    "(+" + country['phone_code'] + ")",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF2A2A2A),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      this.country_selected = true;
                                      controller.country_name =
                                          RxString(country['country_name']);
                                      controller.country_code =
                                          RxString(country['phone_code']);
                                      controller.country_image =
                                          RxString(country['image']);
                                      print(country_selected);
                                    });
                                  },
                                );
                              },
                            ),
                          )
                        : Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                CircularProgressIndicator.adaptive(),
                                SizedBox(
                                  height: 30,
                                ),
                                Text("Loading Country List"),
                              ],
                            ),
                          ),
                  ),
                ),
                Visibility(
                  visible: country_selected == true ? true : false,
                  child: Positioned(
                    bottom: 10,
                    left: MediaQuery.of(context).size.width / 2 - 90,
                    child: FloatingActionButton.extended(
                      label: Text(
                        "  Confirm  ",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ), // <-- Text
                      backgroundColor: Color(0xff262F3E),

                      onPressed: () {
                        Get.to(() => HomePage());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
