import 'dart:convert';

import 'package:doctor_app/Screen/Myprofile.dart';
import 'package:doctor_app/Screen/Termandcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screen/ContacUs.dart';
import 'Screen/FaqScreen.dart';
import 'Screen/LoginScreen.dart';
import 'Utils/CustomCard.dart';


String? wallet_balance;

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Account",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/29,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 80,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      InkWell(
                          onTap:() {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> MyProfile()));
                          },
                          child: CustomCard2(title: "My Profile", title2: "Doctor Profile", icon: CupertinoIcons.profile_circled)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/80,
                      ),
                      // CustomCard2(title: "My Orders", title2: "Order Status", icon:Icons.cyclone),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height/80,
                      // ),
                      // InkWell(
                      //     onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SavedAddress()));},
                      //     child: CustomCard2(title: "My Address", title2: "Save Address", icon: CupertinoIcons.location_solid,)),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height/80,
                      // ),
                      // CustomCard2(title: "Change Language", title2: "Change Language", icon: CupertinoIcons.globe,),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height/80,
                      // ),
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Contactus()));
                          },
                          child: CustomCard2(title: "Contact us", title2: "Let us help you", icon: CupertinoIcons.chat_bubble_text)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/80,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>  FaqScreen()));
                          },
                          child: CustomCard2(title: "FAQs", title2: "Quick Answers", icon: CupertinoIcons.arrow_down_left_square_fill,)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/80,
                      ),
                      // InkWell(
                      //     onTap: () {
                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=> TermCondition()));
                      //     },
                      //     child: CustomCard2(title: "Term & Condition", title2: "Term & Condition", icon: CupertinoIcons.arrow_down_left_square_fill,)),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/50,),
                  Column(
                    children: [
                      // InkWell(
                      //     onTap: (){
                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=> WalletScreen()));
                      //     },
                      //     child: CustomCard2(title: "Wallet", title2: "Quick Payments", icon: Icons.account_balance_wallet,)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/80,
                      ),
                      // InkWell(
                      //     onTap: (){
                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=> const PetsProfile()));
                      //     },
                      //     child: CustomCard2(title: "Pets", title2: "Pet Profile", icon: CupertinoIcons.clock,)),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height/80,
                      // ),
                      // CustomCard2(title: "Saved", title2: "Meds & Doctors", icon: CupertinoIcons.bookmark_fill,),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height/80,
                      // ),
                      // CustomCard2(title: "Change Theme", title2: "Change Theme", icon: CupertinoIcons.paintbrush_fill,),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height/80,
                      // ),
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Terms()));
                          },
                          child: CustomCard2(title: "T&C", title2: "Company Policies", icon: CupertinoIcons.book)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/80,
                      ),
                      InkWell(
                          onTap: () async {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirm log out"),
                                    content: const Text("Are you sure you won't to log out"),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        style:
                                        ElevatedButton.styleFrom(primary: Color(0xFF1F61AC)),
                                        child: const Text("YES"),
                                        onPressed: () async {
                                          SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                          prefs.clear();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login()),
                                          );
                                        },
                                      ),
                                      ElevatedButton(
                                        style:
                                        ElevatedButton.styleFrom(primary: Color(0xFF1F61AC)),
                                        child: const Text("NO"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: CustomCard2(title: "Logout", title2: "Logout", icon: Icons.logout_outlined,)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/80,
                      ),
                      // InkWell(
                      //     onTap: () {
                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=> const SendToBankPage()));
                      //     },
                      //     child: CustomCard2(title: "Send to Bank", title2: "Send to Bank", icon: CupertinoIcons.arrow_down_left_square_fill,)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
