import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' ;

import '../Utils/CustomButton.dart';
import '../Utils/CustomTextFormField.dart';
import 'package:http/http.dart'as http;

import 'Verify_otp.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mobilecn = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  sendotp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // SizedBox(
                //   height: MediaQuery
                //       .of(context)
                //       .size
                //       .height / 12,
                // ),
                // Align(
                //   alignment: Alignment.center,
                //   child: Container(
                //     height: 100,
                //     width: 100,
                //     child: Image.asset('assets/images/Group 165.png'),
                //   ),
                // ),
                // Text(
                //   "Care Provider App",
                //   style: TextStyle(fontSize: 15, color: Colors.grey),
                // ),
                // SizedBox(
                //   height: MediaQuery
                //       .of(context)
                //       .size
                //       .height / 19,
                // ),
                // Container(
                //   height: MediaQuery
                //       .of(context)
                //       .size
                //       .height / 3,
                //   width: MediaQuery
                //       .of(context)
                //       .size
                //       .width / 1,
                //   child: Image.asset('assets/images/Group 423.png'),
                // ),
                // SizedBox(
                //   height: MediaQuery
                //       .of(context)
                //       .size
                //       .height / 39,
                // ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 12,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/images/Group 165.png'),
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 19,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width / 1,
                  child: Image.asset('assets/images/Group 423.png'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 39,
                ),
                Form(
                  key: _formKey,
                  child:

                  Card(
                    elevation: 3,
                    child: Container(
                      height: MediaQuery.of(context).size.height/12.7,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                      child: Center(
                        child: TextFormField(
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          controller: mobilecn,
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.call),
                            hintText: "Enter Mobile Mobile",hintStyle: TextStyle(fontFamily: "Montserrat"),
                          ),
                          validator: (v) {
                            if (v!.length < 10) {
                              return "Enter Valid Mobile Number";
                            }
                          },
                        ),
                      ),
                    ),
                  ),


                  //
                  // Card(
                  //   elevation: 3,
                  //   child: Container(
                  //     height: MediaQuery.of(context).size.height/12.7,
                  //
                  //     child: TextFormField(
                  //       keyboardType: TextInputType.phone,
                  //       controller: mobilecn,
                  //       maxLength: 10,
                  //       decoration: const InputDecoration(
                  //           hintText: "Enter Mobile No",
                  //           // fillColor: Colors.indigo[100] ,
                  //           filled: true,
                  //           counterText: '',
                  //           prefixIcon:  Icon(Icons.phone),
                  //           border: InputBorder.none
                  //           // border: OutlineInputBorder(
                  //           //     borderRadius: BorderRadius.circular(8))
                  //       ),
                  //       validator: (value) {
                  //         if ( value!.isEmpty||value.length<10) {
                  //           return "Please Enter Mobile no";
                  //         }
                  //         return null;
                  //       },
                  //     ),
                  //   ),
                  // ),
                  //

                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/69,
                ),
                InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        sendotp();
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>PillRemainders()));
                      }
                    },
                    child: CustomButton(name: "Continue")),
                // SizedBox(
                //   height: MediaQuery
                //       .of(context)
                //       .size
                //       .height / 19,
                // ),

                SizedBox(height: 10,),
                // Text("Or quick continue with",
                //     style: TextStyle(
                //       fontSize: 15,
                //     )),
                //   SizedBox(
                //    height: MediaQuery.of(context).size.height / 69,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Container(
                //       height: MediaQuery
                //           .of(context)
                //           .size
                //           .height / 15,
                //       width: MediaQuery
                //           .of(context)
                //           .size
                //           .width / 2.2,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(8),
                //         color: Colors.blue,
                //       ),
                //       child: Row(
                //         children: [
                //           SizedBox(
                //             width: MediaQuery
                //                 .of(context)
                //                 .size
                //                 .width / 45,
                //           ),
                //           Icon(
                //             Icons.facebook,
                //             color: Colors.white,
                //           ),
                //           SizedBox(
                //             width: MediaQuery
                //                 .of(context)
                //                 .size
                //                 .width / 17,
                //           ),
                //           Text(
                //             "Facebook",
                //             style: TextStyle(fontSize: 17, color: Colors.white),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Container(
                //       height: MediaQuery
                //           .of(context)
                //           .size
                //           .height / 15,
                //       width: MediaQuery
                //           .of(context)
                //           .size
                //           .width / 2.2,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(8),
                //         color: Colors.white,
                //       ),
                //       child: Row(
                //         children: [
                //           SizedBox(
                //             width: MediaQuery
                //                 .of(context)
                //                 .size
                //                 .width / 45,
                //           ),
                //           Container(
                //               height: 26,
                //               width: 26,
                //               child: Image.asset(
                //                   "assets/images/icons8-google-48.png")),
                //           SizedBox(
                //             width: MediaQuery
                //                 .of(context)
                //                 .size
                //                 .width / 17,
                //           ),
                //           Text("Gmail"),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "register");
                    },
                    child: const Text(
                      "Not a registered user? Register with us",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black,fontFamily: "Montserrat"),
                    ),
                ),
              ],
            ),
          ),
        ));
  }

  void sendotp() async {
    var headers = {
      'Cookie': 'ci_session=4ead3edbb4f7470735c26f5c110e941a50b6021a'
    };
    var request = http.MultipartRequest('POST', Uri.parse(
        'https://developmentalphawizz.com/dr_vet_app/seller/app/v1/api/send_otp_doctor'));
    request.fields.addAll({
      'mobile': mobilecn.text.toString(),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result=await response.stream.bytesToString();
      var finalresult=jsonDecode(result);
      if(finalresult['error']== false)
      {
        var otp = finalresult['data']['otp'].toString();
        var mobile = finalresult['data']['mobile'].toString();
        Fluttertoast.showToast(msg: "${finalresult['message']}");
        Navigator.push(context, MaterialPageRoute(builder: (context) => Verify(NewOtp: otp,Mobile: mobile),));
      }
      else{
        Fluttertoast.showToast(msg: "${finalresult['message']}");
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
