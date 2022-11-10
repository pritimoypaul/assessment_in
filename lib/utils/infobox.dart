import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoBox extends StatelessWidget {
  final String icon;
  final String name;
  final String notifications;

  const InfoBox(
      {Key? key,
      required this.icon,
      required this.name,
      required this.notifications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 24,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            name,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.white60,
            ),
          ),
          Text(
            notifications,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
