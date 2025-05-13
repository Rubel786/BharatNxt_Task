import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            kPrimaryColor, // Your color
            kPrimaryShadowColor, // A lighter shade
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: 80, // Adjust height as needed
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'BEAUTY',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Mulish",
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
          SizedBox(width: 12),
          Text(
            'EXCLUSIVE',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Mulish",
              fontWeight: FontWeight.w300,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
