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
    fetch_state();
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
                    height: MediaQuery.of(context).size.height / 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                      ),
                      Text(
                        "MyProfile",
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
                            Image.asset("assets/images/doctor.jpg", fit: BoxFit.cover) : Image.network("${getData?.data[0]['image']}", fit: BoxFit.fill,)
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
                              hintText: "${getData?.data[0]['username'].toString()}",
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
                              hintText: "${getData?.data[0]['mobile'].toString()}",
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
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: gendercn,
                          decoration: InputDecoration(
                              hintText: "${getData?.data[0]['gender'].toString()}",
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
                              hintText: "${getData?.data[0]['email'].toString()}",
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
                              hintText: "${getData?.data[0]['clinic_address'].toString()}",
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
                              hintText: "${getData?.data[0]['experience'].toString()}",
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
                            '  ${getData?.data[0]['service_type'].toString()}',
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
                              hintText: " ${getData?.data[0]['consultancy_fees'].toString()}",
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
                              hintText: "${getData?.data[0]['consultancy_fees'].toString()}",
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
                              hintText: "${getData?.data[0]['open_time'].toString()}",
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
                              hintText: "${getData?.data[0]['close_time'].toString()}",
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
                          // value: selectedState,
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
                            ' ${getData?.data[0]['state'].toString()}',
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
                            '${getData?.data[0]['city'].toString()}',
                            fillColor: Colors.indigo[100] ,
                            filled: true,
                            // label: Text(  'Servive Type',)//
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  // InkWell(onTap: (){
                  //   if(_formKey.currentState!.validate()){
                  //     // Navigator.pushNamed(context, "support");
                  //   }
                  // },
                  //     child: CustomButton(name: 'Update',)),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height / 90,),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
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
        getData=finalresult;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
