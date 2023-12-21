import 'dart:convert';
import 'package:doctor_app/Screen/Homescreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BottomBar.dart';
import 'Colors.dart';

class Verify extends StatefulWidget {
  Verify({super.key, this.NewOtp,this.Mobile});

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
      });
      if(response.statusCode==200) {
        var finalresult=jsonDecode(response.body.toString());
        String? doctor_id = finalresult['data'][0]['id'];
        preferences.setString("doctor_id", doctor_id ?? "");
        print("doctor id iss $doctor_id");
        if(finalresult['error'] == false) {
          Fluttertoast.showToast(msg: 'OTP verifid Successfully Compleated');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const HomeScreen()));
        }
        else{
          Fluttertoast.showToast(msg: finalresult['message']);
        }
      }
    }
    catch(e)
    {
      print(e.toString());
    }
}
  TextEditingController pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
        backgroundColor: AppColorrs.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text("Verify Mobile Number", style: TextStyle(fontSize: 15, color: AppColorrs.primary, fontFamily: "Montserrat")),
          // leading: InkWell(
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          //     child: Icon(Icons.arrow_back_ios_new, color: colors.primary,)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "OTP Sent",
                    style: TextStyle(

                        fontSize: 20,
                        color: AppColorrs.black,
                        fontWeight: FontWeight.w500, fontFamily: "Montserrat"
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Text(
                    "Mobile: ${widget.Mobile.toString()}",
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold,letterSpacing: 1.5, fontFamily: "Montserrat"),
                  ),
                ),
                Text("OTP: ${widget.NewOtp.toString()}",style: const TextStyle(fontFamily: "Montserrat")),
                // OtPTextField(
                //     numberOfFields: 4,
                //     borderColor: Colors.red,
                //     focusedBorderColor: Colors.blue,
                //     showFieldAsBox: false,
                //     borderWidth: 2.0,
                //     //runs when a code is typed in
                //     onCodeChanged: (code) {
                //     },
                //     //runs when every textfield is filled
                //     onSubmit: (String verificationCode) {
                //       pinController.text = verificationCode;
                //       if(widget.NewOtp.toString() == pinController.text) {
                //       } else {
                //         Fluttertoast.showToast(msg: "Otp Incorrect ",backgroundColor: AppColorrs.primary);
                //       }
                //     }
                // ),
                //
                OTPTextField(
                  length: 4,
                   // width: MediaQuery.of(context).size.width/1.1,
                  // fieldWidth: 50,
                  style: const TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  //fieldStyle: FieldStyle.underline,
                  onCompleted: (String verificationCode) {
                    pinController.text = verificationCode;
                    if(widget.NewOtp.toString() == pinController.text){
                    } else
                    {
                      Fluttertoast.showToast(msg: "Otp Incorrect",backgroundColor: AppColorrs.primary);
                    }
                  },
                ),


                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 5),
                  child: Text(
                    "Didn't receive OTP yet?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontFamily: "Montserrat"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // postData(context);
                  },
                  child: const Text("Resend", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: "Montserrat")),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 48,
                  ),
                  // child: InkWell(
                  //   onTap: () {
                  //     verifyData();
                  //     print("${widget.currentOtp}");
                  //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>Sixth()));
                  //   },
                  child: InkWell(
                    onTap: () async {
                      if(pinController.text == widget.NewOtp.toString()) {
                        VerifyOTP();
                      } else {
                        Fluttertoast.showToast(msg: "Please Fill All OTP Fields!",backgroundColor: AppColorrs.primary);
                      }
                      //mobileNumber = mobile;
                      //  final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                      // sharedPreferences.setString('otp1', pinCodeController.text);
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>B2BHome()));
                      // print("$mobileController.text");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColorrs.primary,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                          child: Text(
                            "Submit OTP",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white, fontFamily: "Montserrat"),
                          ),
                      ),
                    ),
                  ),
                ),
              ],
            ),


          ),
        ),
      );

    //
    //   Scaffold(
    //   backgroundColor: Colors.white,
    //     appBar:
    //
    //
    //     AppBar(
    //       elevation: 0,
    //       centerTitle: true,
    //       backgroundColor: Color(0xFF1F61AC),
    //       title: Text("Verify",style: TextStyle(fontSize: 19, color: Colors.white),)),
    //     body: Container(
    //       child: Padding(
    //         padding: const EdgeInsets.only(left: 15,right: 15,top: 30),
    //         child: Column(
    //           children: [
    //             SizedBox(
    //               height: MediaQuery.of(context).size.height / 60,
    //             ),
    //             Text('Verify Your Phone Number',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
    //             Text('Enter your OTP code here',),
    //             SizedBox(
    //               height: MediaQuery.of(context).size.height / 60,
    //             ),
    //             Center(child: Text('Mobile:${widget.Mobile.toString()}')),
    //             Center(child: Text('OTP:${widget.NewOtp.toString()}')),
    //             SizedBox(
    //               height: MediaQuery.of(context).size.height / 17,
    //             ),
    //             OTPTextField(
    //               controller: otpcn,
    //               onChanged: (pin) {
    //                 setState(() {
    //                   verifie=pin;
    //                 });
    //               },
    //               fieldWidth:50 ,
    //               length: 4,
    //               width: MediaQuery.of(context).size.width,
    //               textFieldAlignment: MainAxisAlignment.spaceEvenly,
    //               fieldStyle:FieldStyle.box ,
    //             ),
    //             SizedBox(
    //               height: MediaQuery.of(context).size.height / 17,
    //             ),
    //             Container(
    //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
    //               height: MediaQuery.of(context).size.height*.05,
    //               width: MediaQuery.of(context).size.width/1.2,
    //               child: ElevatedButton(
    //                   style: ElevatedButton.styleFrom(
    //                     primary: Color(0xFF1F61AC),
    //                   ),
    //                   onPressed: (){
    //                 VerifyOTP();
    //               }, child: Text("Verify Otp", style: TextStyle(fontSize: 15, color: Colors.white),)),
    //             ),
    //           ],
    //         ),
    //       ),
    //     )
    // );
    //
    //

  }
}
