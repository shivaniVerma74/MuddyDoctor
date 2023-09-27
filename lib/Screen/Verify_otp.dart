import 'dart:convert';
import 'package:doctor_app/Screen/Homescreen.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BottomBar.dart';
class Verify extends StatefulWidget {
  Verify({super.key, this.NewOtp,this.Mobile,});
  String? NewOtp,Mobile;
  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  OtpFieldController otpcn=OtpFieldController();
  var verifie;

void  VerifyOTP() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
    try{
      Response response=await post(Uri.parse('https://developmentalphawizz.com/dr_vet_app/seller/app/v1/api/verify_otp_doctor'),
          body: {
             'mobile': widget.Mobile,
            'otp':widget.NewOtp.toString(),
            'Device_token': ""
      });
      if(response.statusCode==200){
        var finalresult=jsonDecode(response.body.toString());
        String? doctor_id = finalresult['data'][0]['id'];
        preferences.setString("doctor_id", doctor_id ?? "");
        print("doctor id iss ${doctor_id}");
        if(widget.NewOtp == verifie){
          Fluttertoast.showToast(msg: 'Register Success');
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  BottomNavigationBarExampleApp()));
        }
        else{
          Fluttertoast.showToast(msg: 'Enter correct otp');
        }
      }
    }
    catch(e)
    {
      print(e.toString());
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xFF1F61AC),
          title: Text("Verify",style: TextStyle(fontSize: 19, color: Colors.white),)),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 30),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 60,
                ),
                Text('Verify Your Phone Number',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                Text('Enter your OTP code here',),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 60,
                ),
                Center(child: Text('Mobile:${widget.Mobile.toString()}')),
                Center(child: Text('OTP:${widget.NewOtp.toString()}')),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 17,
                ),
                OTPTextField(
                  controller: otpcn,
                  onChanged: (pin) {
                    setState(() {
                      verifie=pin;
                    });
                  },
                  fieldWidth:50 ,
                  length: 4,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceEvenly,
                  fieldStyle:FieldStyle.box ,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 17,
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                  height: MediaQuery.of(context).size.height*.05,
                  width: MediaQuery.of(context).size.width/1.2,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF1F61AC),
                      ),
                      onPressed: (){
                    VerifyOTP();
                  }, child: Text("Verify Otp", style: TextStyle(fontSize: 15, color: Colors.white),)),
                ),
              ],
            ),
          ),
        )
    );
  }
}
