import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class button extends StatefulWidget {
  const button(
      {required this.text,
      required this.color,
      required this.buttoncolor, required this.buttontapped});
  final  text;
  final color;
  final buttoncolor;
  final buttontapped;

  @override
  _buttonState createState() => _buttonState();
}

class _buttonState extends State<button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: ClipRRect(
        //   borderRadius: BorderRadius.circular(20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // color: Color(0xFF004ca9)
              // border: B,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 6,
                  color: Colors.grey,
                ),
              ],
            ),
            // color: widget.color,
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(fontSize: 26.0,fontWeight: FontWeight.w600
                ,color: widget.buttoncolor),
              ),
            ),
          // ),
        ),
      ),
      onTap: widget.buttontapped,
    );
  }
}
