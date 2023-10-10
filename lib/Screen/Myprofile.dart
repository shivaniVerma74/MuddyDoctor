import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/GetData.dart';
import '../Model/Get_city.dart';
import '../Model/Get_state.dart';
import '../Utils/CustomButton.dart';

String? wallet_balance;
class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController phonecn=TextEditingController();
  final TextEditingController namecn=TextEditingController();
  final  TextEditingController emailcn=TextEditingController();
  final  TextEditingController cliniaddcn=TextEditingController();
  final TextEditingController exprincecn=TextEditingController();
  final TextEditingController consentencycn=TextEditingController();
  final TextEditingController storedcn=TextEditingController();
  final  TextEditingController opentimecn=TextEditingController();
  final TextEditingController closetimecn=TextEditingController();
  final TextEditingController gendercn=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String? Service_type;
  var Service_Type=['Online','InClinic','both'];
  List<String> cities = []; // Store the list of cities
  List<String> states = []; // Store the list of cities
  String? selectedCity ;
  String? selectedState ;

  var cityId;
  var stateId;
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTime1 = TimeOfDay.now();

  @override
  void initState(){
    super.initState();
    getIdData();
  }
  var userId;
  Future<void> getIdData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId= preferences.getString('docIdd');
    getdata();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(

          child: Column(children: [
            // SizedBox(
            //   height: MediaQuery.of(context).size.height / 12,
            // ),
            Container(padding: EdgeInsets.all(10),
              // height: MediaQuery.of(context).size.height / 15,
              // width: MediaQuery.of(context).size.width / 1.3,
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(4),color: Colors.white),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height/18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                      ),
                      const Text(
                        "My Profile",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: imageFile == null ||imageFile == "" ?
                            Image.asset("assets/images/doctor.jpg", fit: BoxFit.cover) : Image.network("${getData?.data?[0].image}", fit: BoxFit.fill,)
                          ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/22,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height/9,
                            ),
                            InkWell(
                              onTap: () {
                                showExitPopup();
                              },
                                child: Icon(Icons.camera_alt,color: Colors.blue)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 102,
                            ),
                            Text("Change Profile Picture",style: TextStyle(color: Colors.blue,fontSize: 13,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 90,
            ),
            Container(padding: EdgeInsets.all(10),
              // height: MediaQuery.of(context).size.height / 15,
              // width: MediaQuery.of(context).size.width / 1.3,
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(4),color: Colors.white),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: namecn,
                          decoration: InputDecoration(
                              hintText: "${getData?.data?[0].username.toString()}",
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
                              hintText: "${getData?.data?[0].mobile.toString()}",
                              fillColor: Colors.indigo[100] ,
                              filled: true,
                              counterText: '',
                              prefixIcon:  Icon(Icons.phone),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
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
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: gendercn,
                          decoration: InputDecoration(
                              hintText: "${getData?.data?[0].gender.toString()}",
                              fillColor: Colors.indigo[100] ,
                              filled: true,
                              prefixIcon:  Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          validator: (value) {
                            if ( value!.isEmpty) {
                              return "Please Enter Gender";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 60,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailcn,
                          decoration: InputDecoration(
                              hintText: "${getData?.data?[0].email.toString()}",
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
                          controller: cliniaddcn,
                          decoration: InputDecoration(
                              hintText: "${getData?.data?[0].clinicAddress.toString()}",
                              fillColor: Colors.indigo[100] ,
                              filled: true,
                              counterText: '',
                              prefixIcon:  Icon(Icons.location_on_sharp),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          validator: (value) {
                            if ( value!.isEmpty) {
                              return "Please Enter address";
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
                              hintText: "${getData?.data?[0].experience.toString()}",
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
                        DropdownButtonFormField<String>(
                          value: Service_type,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Service type';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (newValue) {
                            setState(() {
                              Service_type= newValue;
                            });
                          },
                          items:Service_Type .map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          //   icon  : Icon(Icons.medical_services),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            hintText:
                            '  ${getData?.data?[0].serviceType.toString()}',
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
                              hintText: " ${getData?.data?[0].consultancyFees.toString()}",
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
                              hintText: "${getData?.data?[0].consultancyFees.toString()}",
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
                              hintText: "${getData?.data?[0].openTime.toString()}",
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
                              hintText: "${getData?.data?[0].closeTime.toString()}",
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/50,
                  ),
                  InkWell(
                      onTap: () {
                    if(_formKey.currentState!.validate()){
                      // Navigator.pushNamed(context, "support");
                    }
                  },
                      child: CustomButton(name: 'Update',)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 90,),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }


  File? imageFile;
  File? petImage;
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Image'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                _getFromCamera();
              },
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.camera_alt,color: Colors.white,),
                  SizedBox(width: 10,),
                  Text('Image from Camera'),
                ],
              ),
            ),
            const SizedBox(height: 15,),
            ElevatedButton(
              onPressed: (){
                _getFromGallery();
              },
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.photo,color: Colors.white,),
                  SizedBox(width: 10,),
                  Text('Image from Gallery'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GetData? getData;
  Future<void> getdata()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? doctor_id = preferences.getString('doctor_id');
    var headers = {
      'Cookie': 'ci_session=ff134e543f4868d8d94ffd3e079ae3a6691a7fed'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_vet_app/seller/app/v1/api/get_user_data'));
    request.fields.addAll({
      'user_id': "${doctor_id}"
    });
    print("doctor id iss ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data=await response.stream.bytesToString();
      var finalresult=GetData.fromJson(json.decode(data));

      setState(() {
        wallet_balance = getData?.data?[0].balance.toString();
        preferences.setString('wallet_balance', wallet_balance ?? "");
        getData=finalresult;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
