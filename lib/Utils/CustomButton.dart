import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String name;
  const CustomButton({Key? key,required this.name}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height / 14.7,
      width: MediaQuery.of(context).size.width / 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFF1F61AC),
      ),
      child: Center(
          child: Text(
            widget.name,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.white,fontFamily: "Montserrat"),
          )),
    );
  }
}
