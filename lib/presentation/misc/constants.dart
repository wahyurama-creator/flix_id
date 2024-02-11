import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color backgroundColor = Color(0xFF1F1D2B);
const Color ghostWhiteColor = Color(0xFFF6F8FF);
const Color saffronColor = Color(0xFFF4C95D);

TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: ghostWhiteColor,
  fontWeight: regular,
  fontSize: 14,
);

TextStyle saffronTextStyle =
    GoogleFonts.poppins(color: saffronColor, fontWeight: regular, fontSize: 14);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w500;
FontWeight bold = FontWeight.w700;

// Privacy & Policy
String privacyAndPolicy = '''
  At Flix.Ids, accessible from www.flix-ids.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Flix.Ids and how we use it.
  
  If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.
'''
    .trim();
String logFiles = '''
  Flix.Ids follows a standard procedure of using log files. These files log visitors when they visit websites. All hosting companies do this and a part of hosting services' analytics. The information collected by log files include internet protocol (IP) addresses, browser type, Internet Service Provider (ISP), date and time stamp, referring/exit pages, and possibly the number of clicks. These are not linked to any information that is personally identifiable. The purpose of the information is for analyzing trends, administering the site, tracking users' movement on the website, and gathering demographic information. Our Privacy Policy was created with the help of the Privacy Policy Generator.
'''
    .trim();
String policies = '''
  You may consult this list to find the Privacy Policy for each of the advertising partners of Flix.Ids.

  Third-party ad servers or ad networks uses technologies like cookies, JavaScript, or Web Beacons that are used in their respective advertisements and links that appear on Flix.Ids, which are sent directly to users' browser. They automatically receive your IP address when this occurs. These technologies are used to measure the effectiveness of their advertising campaigns and/or to personalize the advertising content that you see on websites that you visit.
  
  Note that Flix.Ids has no access to or control over these cookies that are used by third-party advertisers.
'''
    .trim();
