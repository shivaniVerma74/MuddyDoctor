import 'dart:async';
import 'dart:convert';
import 'package:doctor_app/Model/Get_state.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:geolocator/geolocator.dart';
import '../Model/Get_city.dart';
import '../Utils/CustomButton.dart';
import 'package:http/http.dart'as http;

import 'LoginScreen.dart';
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  State<Register> createState() => _RegisterState();
}
var homelat;
var homeLong;
class _RegisterState extends State<Register> {

  final TextEditingController phonecn=TextEditingController();
  final TextEditingController namecn=TextEditingController();
  final  TextEditingController emailcn=TextEditingController();
  final  TextEditingController passwordcn=TextEditingController();
  final TextEditingController exprincecn=TextEditingController();
  final TextEditingController consentencycn=TextEditingController();
  final TextEditingController storedcn=TextEditingController();
  final  TextEditingController opentimecn=TextEditingController();
  final TextEditingController closetimecn=TextEditingController();
  final TextEditingController clinicCtr=TextEditingController();
  final TextEditingController docidcn=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isHidden=true;
  String dropdownvalue = "online";
  var items = [
    'online',
    'Inclinic',
    'both',
  ];
  //String? Service_type;
  // List<String> Service_Type=['Online','InClinic','both'];

  String? selectedCity ;
  String? selectedState ;
  String? gender="Female";
  int num=1;
  var cityId;
  var stateId;


  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTime1 = TimeOfDay.now();
  @override
  void initState(){
    super.initState();
    fetch_state();
    // fetch_city();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 12,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                // width: MediaQuery.of(context).size.width / 1.3,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        FocusScope.of(context).unfocus();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                    Text(
                      "Register Now",
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),),
              SizedBox(
                height: MediaQuery.of(context).size.height / 17,
              ),
              Text(
                "Your phone number is not registered yet.",
                style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
              ),
              Text(
                "Let us know basic details for registration.",
                style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 17,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [

                    TextFormField(
                      controller: namecn,
                      decoration: InputDecoration(
                          hintText: "Enter Name",
                          fillColor: Colors.indigo[100] ,
                          filled: true,
                          prefixIcon:  Icon(Icons.person),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phonecn,
                      maxLength: 10,
                      decoration: InputDecoration(
                          hintText: "Enter Mobile No",
                          fillColor: Colors.indigo[100] ,
                          filled: true,
                          counterText: '',
                          prefixIcon:  Icon(Icons.phone),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),

                      validator: (value) {
                        if ( value!.isEmpty||value.length<10) {
                          return "Please Enter Mobile no";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    Row(
                      children: [
                        Radio(
                          //  activeColor: Color(0xff7F62B0),
                            value: "Male",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                num = 0;
                                gender = value.toString();
                              });
                            }),
                        Text("Male",
                          // style: TextStyle(color: Color(0xff7F62B0))
                        ),
                        Radio(
                          //   activeColor: Color(0xff7F62B0),
                            value: "Female",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                num = 1;
                                gender = value.toString();
                              });
                            }),
                        Text(
                          "Female",
                          // style: TextStyle(color: Color(0xff7F62B0)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcn,
                      decoration: InputDecoration(
                          hintText: "Enter Email",
                          fillColor: Colors.indigo[100] ,
                          filled: true,
                          counterText: '',
                          prefixIcon:  Icon(Icons.email),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),

                      validator: (value) {
                        if ( value!.isEmpty) {
                          return "Please Enter email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordcn,
                      obscureText: isHidden,
                      maxLength: 8,
                      decoration: InputDecoration(
                          hintText: "Enter Password",

                          fillColor: Colors.indigo[100] ,
                          filled: true,
                          counterText: '',
                          prefixIcon:  Icon(Icons.lock),
                          suffixIcon: InkWell(onTap: PaaswordView,
                              child: Icon(Icons.visibility)),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),

                      validator: (value) {
                        if ( value!.isEmpty||value.length<6) {
                          return "Please Enter password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: clinicCtr,
                      decoration: InputDecoration(
                          hintText: "Enter Address",
                          fillColor: Colors.indigo[100] ,
                          filled: true,
                          counterText: '',
                          prefixIcon:  Icon(Icons.location_on_sharp),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),

                      validator: (value) {
                        if ( value!.isEmpty) {
                          return "Please Enter location";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller:exprincecn,

                      decoration: InputDecoration(
                          hintText: "Enter Experience",
                          fillColor: Colors.indigo[100] ,
                          filled: true,
                          counterText: '',
                          prefixIcon:  Icon(Icons.person),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),

                      validator: (value) {
                        if ( value!.isEmpty) {
                          return "Please Enter experince";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    // DropdownButtonHideUnderline(
                    //   child: DropdownButton2(
                    //     isExpanded: true,
                    //     // Initial Value
                    //     value: dropdownvalue,
                    //     hint: Icon(Icons.arrow_drop_down_outlined),
                    //     items: items.map((String items) {
                    //       return DropdownMenuItem(
                    //         value: items,
                    //         child: Text(items),
                    //       );
                    //     }).toList(),
                    //     // After selecting the desired option,it will
                    //     // change button value to selected value
                    //     onChanged: (String? newValue) {
                    //       setState(() {
                    //         dropdownvalue = newValue!;
                    //       });
                    //     },
                    //   ),
                    // ),
                    DropdownButtonFormField<String>(
                      value: dropdownvalue,
                      hint: Icon(Icons.arrow_drop_down_outlined),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Service type';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue= newValue!;
                        });
                      },
                      items:items .map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      //   icon  : Icon(Icons.medical_services),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        hintText:
                        '  Service Type',
                        fillColor: Colors.indigo[100] ,
                        filled: true,
                        // label: Text(  'Servive Type',)//
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller:consentencycn,

                      decoration: InputDecoration(
                          hintText: "Enter Consentency Fees",
                          fillColor: Colors.indigo[100] ,
                          filled: true,
                          counterText: '',
                          prefixIcon:  Icon(Icons.currency_rupee),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),

                      validator: (value) {
                        if ( value!.isEmpty) {
                          return "Please Enter counsentency fees";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller:storedcn,

                      decoration: InputDecoration(
                          hintText: "Enter Store Description",
                          fillColor: Colors.indigo[100] ,
                          filled: true,
                          counterText: '',
                          prefixIcon:  Icon(Icons.person),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),

                      validator: (value) {
                        if ( value!.isEmpty) {
                          return "Please Enter description";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    TextFormField(
                      controller: opentimecn,
                      decoration: InputDecoration(
                          hintText: "Open Time",
                          fillColor: Colors.indigo[100] ,
                          filled: true,
                          prefixIcon: IconButton(
                            onPressed: () async {
                              showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                              ).then((value) {
                                setState(() {
                                  selectedTime = value!;
                                  opentimecn.text = selectedTime
                                      .format(context)
                                      .toString();
                                });
                              });
                            },
                            icon: const Icon(Icons.watch_later_rounded),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        ).then((value) {
                          setState(() {
                            selectedTime = value!;
                            opentimecn.text =
                                selectedTime.format(context).toString();
                          });
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Select Time";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    TextFormField(
                      controller: closetimecn,
                      decoration: InputDecoration(
                          hintText: "Close Time",
                          fillColor: Colors.indigo[100] ,
                          filled: true,
                          prefixIcon: IconButton(
                            onPressed: () async {
                              showTimePicker(
                                context: context,
                                initialTime: selectedTime1,
                              ).then((value) {
                                setState(() {
                                  selectedTime1 = value!;
                                  opentimecn.text = selectedTime1
                                      .format(context)
                                      .toString();
                                });
                              });
                            },
                            icon: const Icon(Icons.watch_later_rounded),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: selectedTime1,
                        ).then((value) {
                          setState(() {
                            selectedTime1 = value!;
                            closetimecn.text =
                                selectedTime1.format(context).toString();
                          });
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Please Select Time";
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedState,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your state';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (newValue) {
                        setState(() {
                          stateId=newValue;
                          print('======${stateId}');
                          fetch_city();
                          // cityId=null;

                        });
                      },
                      items:getState?.data.map((items) {
                        return DropdownMenuItem(
                          value: items.id.toString()??'',
                          child: Text(items.name??''),

                        );}).toList(),

                      //   icon  : Icon(Icons.medical_services),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        hintText:
                        '  State',
                        fillColor: Colors.indigo[100] ,
                        filled: true,
                        // label: Text(  'Servive Type',)//
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    DropdownButtonFormField<String>(
                      // value: selectedCity,
                      validator: (value) {
                        if (value==null|| value.isEmpty) {
                          return 'Please Enter Your City';
                        } else {
                          return null;
                        }
                      },

                      onChanged: (newValue) {
                        setState(() {
                          cityId=newValue;
                          print(cityId);


                        });
                      },


                      items: getCity?.data.map((items) {
                        return DropdownMenuItem(
                          value: items.id.toString()??'',
                          child: Text(items.name??''),
                        );
                      }).toList(),

                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        hintText:
                        'City',
                        fillColor: Colors.indigo[100] ,
                        filled: true,
                        // label: Text(  'Servive Type',)//
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 17,
              ),
              InkWell(
                  onTap: () async {
                    ///1st UI
                    if(_formKey.currentState!.validate()) {
                      await  register();
                      // Navigator.pushNamed(context, "myAppointments");
                    } ///2nd UI
                    // Navigator.pushNamed(context, "findPetStuff");
                  },
                  child: CustomButton(name: "Continue")),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Back to sign in",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Text(
                "We'll send an OTP on above",
                style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
              ),
              Text(
                "given phone number",
                style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
              ),
              //   ElevatedButton(onPressed: (){getLocation();}, child: Text('location'))
            ],
          ),
        ),
      ),
    );
  }

  GetCity? getCity;
  void fetch_city()async{

    var headers = {
      'Cookie': 'ci_session=2c03ee94b38d09c61ef05aca49a722333535f734'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_vet_app/app/v1/api/get_cities'));
    request.fields.addAll({
      'state_id': '${stateId.toString()}'
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data=await response.stream.bytesToString() ;
      // print('city==${data}');
      var finalresult=GetCity.fromJson(json.decode(data));
      setState(() {
        getCity = finalresult;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  GetState? getState;
  void fetch_state()async{
    var headers = {
      'Cookie': 'ci_session=e32f527aeaa52b5e5592c3c5f7c2a8995e3faa40'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_vet_app/app/v1/api/get_states'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var finalresult = GetState.fromJson(json.decode(data));
      setState(() {
        getState=finalresult;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  Future<void> register() async {
    var headers = {
      'Cookie': 'ci_session=1f5168f9f8d6530398df5dcac5a2d39162c175d1'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_vet_app/seller/app/v1/api/register_doctor'));
    request.fields.addAll({
      'name': namecn.text,
      'email':emailcn.text,
      'password': passwordcn.text,
      'mobile': phonecn.text,
      'gender': gender.toString(),
      'experience': exprincecn.text,
      'country_code': '+91',
      'cuncultancy_fees': consentencycn.text,
      'open_time': opentimecn.text,
      'close_time': closetimecn.text,
      'service_type': dropdownvalue.toString(),
      'store_description': storedcn.text,
      'latitute': '22.7468891',
      'longtitute': '75.8980215',
      'clinic_address': clinicCtr.text,
      'state': stateId.toString(),
      'city': cityId.toString(),
      //   'city': items.toString(),
    });
    print("register para ${request.fields}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result=await response.stream.bytesToString();
      var finalresult=jsonDecode(result);
      if(finalresult['error']==false){
        print("responseeee ${finalresult}");
        Fluttertoast.showToast(msg: "${finalresult['message']}");
        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
        // Navigator.pushNamed(context, "myAppointments");
      }
      else{
        Fluttertoast.showToast(msg: "${finalresult['message']}");
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  void PaaswordView() {
    setState(() {
      isHidden=!isHidden;
    });
  }
}

