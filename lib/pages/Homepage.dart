import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:assessment_in/utils/infobox.dart';
import 'package:get/get.dart';
import 'package:assessment_in/pages/Listpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 250,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: AssetImage("images/bg.png"), fit: BoxFit.cover),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset("images/close.svg", height: 16),
                        SvgPicture.asset("images/Share.svg", height: 16),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Image(
                      image: AssetImage("images/Profile.png"),
                      height: 100,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Lucile Barrett",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "New York, NY",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 76,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InfoBox(
                          icon: "images/Alert.svg",
                          name: "Alerts",
                          notifications: "6",
                        ),
                        InfoBox(
                          icon: "images/Places.svg",
                          name: "Places",
                          notifications: "40",
                        ),
                        InfoBox(
                          icon: "images/Shots.svg",
                          name: "Shots",
                          notifications: "60",
                        ),
                        InfoBox(
                          icon: "images/Friends.svg",
                          name: "Friends",
                          notifications: "60",
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Select Country",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2A2A2A),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFF70707033), width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                title: Text(
                  'Search',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF757575),
                  ),
                ),
                onTap: () {
                  Get.to(ListPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
