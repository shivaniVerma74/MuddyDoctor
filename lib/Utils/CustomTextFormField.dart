import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {


  CustomTextFormField({Key? key, required this.name, required this.width, this.hint, this.controller,
    this.validString,this.Icon,this.validator,this.maxlength,this.InputType}) : super(key: key);
  final String name;

  final String? Function(String?)? validator;
  final double width;
  final String? hint;
   var InputType;
  final int? maxlength;
  IconData? Icon;
  final TextEditingController? controller;
  final String? validString;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.unfocus();
  }
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return  Container(
   //   height: MediaQuery.of(context).size.height/14.7,
    //  width: widget.width,
     // decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.indigo[100]),
      child: Center(
        child: TextFormField(
          keyboardType: widget.InputType,
          maxLength:widget.maxlength ,
          validator: widget.validator,
          // enabled: false,
          focusNode: _focusNode,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
           // border: InputBorder.none,
            prefixIcon: Icon(widget.Icon),
             fillColor: Colors.indigo[100] ,
             filled: true,
            hintText: widget.hint,
            counterText: '',
          ),
        ),
      ),
    );
  }
}
