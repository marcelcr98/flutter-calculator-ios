import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalcButton extends StatelessWidget {
  const CalcButton({
    super.key,
    required this.callback,
    required this.text,
    this.textSize = 28,
    //this.bgcolor = 0xFF21252B,
    this.bgcolor = 0xFF3D91C0,
    this.width = 70,
    this.height = 70,
  });

  final Function callback;
  final int bgcolor;
  final String text;
  final double textSize;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: SizedBox(
        width: width,
        height: height,
        child: TextButton(
          onPressed: () => callback(text),
          style: TextButton.styleFrom(
            backgroundColor: Color(bgcolor),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.rubik(
              textStyle: TextStyle(fontSize: textSize, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
