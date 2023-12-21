import 'dart:convert';
import 'dart:io';
import 'package:doctor_app/Screen/Colors.dart';
import 'package:doctor_app/Screen/Homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final  TextEditingController clinicname=TextEditingController();
  final TextEditingController exprincecn=TextEditingController();
  final TextEditingController consentencycn=TextEditingController();
  final TextEditingController storedcn=TextEditingController();
  final  TextEditingController opentimecn=TextEditingController();
  final TextEditingController closetimecn=TextEditingController();
  final TextEditingController gendercn=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String? Service_type;
  var Service_Type=['Online','In-clinic','Online and In-clinic Both'];
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
      body: getData?.data == null || getData?.data == "" ? Container(height: MediaQuery.of(context).size.height/1.2,
        child: const Center(child: CircularProgressIndicator(color: AppColorrs.primary))):
      SingleChildScrollView(
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
                        width: MediaQuery.of(context).size.width/3,
                      ),
                      const Text(
                        "My Profile",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: imageFile == null || imageFile == "" ?
                            // Image.asset("assets/images/doctor.jpg", fit: BoxFit.cover) :
                            // imageFile == null ||imageFile == "" ?
                            Image.network("${getData?.data?[0].image}", fit: BoxFit.fill):
                            Image.file(imageFile!, fit: BoxFit.fill)
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
                                showExitPopup("userImage");
                              },
                                child: const Icon(Icons.camera_alt,color: AppColorrs.primary)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 102,
                            ),
                            const Text("Change Profile Picture",style: TextStyle(color:AppColorrs.primary,fontSize: 13,fontWeight: FontWeight.bold,fontFamily: "Montserrat")),
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
            Container(padding: const EdgeInsets.all(10),
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
                        Card(
                          elevation: 3,
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColorrs.white),
                            child: TextFormField(
                              controller: namecn,
                              decoration:  InputDecoration(
                                  hintText: "${getData?.data?[0].username.toString()}",hintStyle: const TextStyle(fontFamily: "Montserrat"),
                                //   fillColor: Colors.indigo[100] ,
                                 //filled: true,
                                  prefixIcon:  Icon(Icons.person),
                                  border: InputBorder.none
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(10), ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter name";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 60,
                        ),
                        Card(
                          elevation: 3,
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColorrs.white),
                            child: TextFormField(
                              readOnly: true,
                              controller: phonecn,
                              decoration:  InputDecoration(
                                  hintText: "${getData?.data?[0].mobile.toString()}",hintStyle: const TextStyle(fontFamily: "Montserrat"),
                                  //   fillColor: Colors.indigo[100] ,
                                  //filled: true,
                                  prefixIcon:  const Icon(Icons.phone),
                                  border: InputBorder.none
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(10), ),
                              ),
                              validator: (value) {
                                if ( value!.isEmpty||value.length<10) {
                                  return "Please Enter Mobile Number";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 60,
                        ),
                        Card(
                          elevation: 3,
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColorrs.white),
                            child: TextFormField(
                              controller: gendercn,
                              decoration:  InputDecoration(
                                  hintText: "${getData?.data?[0].gender.toString()}",hintStyle: const TextStyle(fontFamily: "Montserrat"),
                                  //   fillColor: Colors.indigo[100] ,
                                  //filled: true,
                                  prefixIcon:  Icon(Icons.person),
                                  border: InputBorder.none
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(10), ),
                              ),
                              validator: (value) {
                                if ( value!.isEmpty) {
                                  return "Please Enter Gender";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 60,
                        ),
                        Card(
                          elevation: 3,
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColorrs.white),
                            child: TextFormField(
                              readOnly: true,
                              controller: emailcn,
                              decoration:  InputDecoration(
                                  hintText: "${getData?.data?[0].email.toString()}",hintStyle: const TextStyle(fontFamily: "Montserrat"),
                                  //   fillColor: Colors.indigo[100] ,
                                  //filled: true,
                                  prefixIcon:  const Icon(Icons.email),
                                  border: InputBorder.none
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(10), ),
                              ),
                              validator: (value) {
                                if ( value!.isEmpty) {
                                  return "Please Enter Email";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 60,
                        ),
                        Card(
                          elevation: 3,
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColorrs.white),
                            child: TextFormField(
                              controller: cliniaddcn,
                              decoration:  InputDecoration(
                                  hintText: "${getData?.data?[0].clinicAddress.toString()}",hintStyle: const TextStyle(fontFamily: "Montserrat"),
                                  //   fillColor: Colors.indigo[100] ,
                                  //filled: true,
                                  prefixIcon:  const Icon(Icons.location_on_sharp),
                                  border: InputBorder.none
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(10), ),
                              ),
                              validator: (value) {
                                if ( value!.isEmpty) {
                                  return "Please Enter Address";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 60,
                        ),
                        Card(
                          elevation: 3,
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColorrs.white),
                            child: TextFormField(
                              controller: exprincecn,
                              decoration:  InputDecoration(
                                  hintText: getData?.data?[0].experience.toString()??'',hintStyle: const TextStyle(fontFamily: "Montserrat"),
                                  //   fillColor: Colors.indigo[100] ,
                                  filled: true,
                                  prefixIcon:  const Icon(Icons.person),
                                  border: InputBorder.none
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(10), ),
                              ),
                              validator: (value) {
                                if ( value!.isEmpty) {
                                  return "Please Enter Experience";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 60,
                        ),
                        Card(
                          elevation: 3,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
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
                                border: InputBorder.none,
                                prefixIcon:  const Icon(Icons.ac_unit,color: Colors.grey,),
                                // border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                hintText:
                                '  ${getData?.data?[0].serviceType.toString()}',hintStyle: const TextStyle(fontFamily: "Montserrat"),
                               // fillColor: Colors.indigo[100] ,
                               // filled: true,
                                // label: Text(  'Servive Type',)//
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 60,
                        ),
                        Card(
                          elevation: 3,
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColorrs.white),
                            child: TextFormField(
                              controller: consentencycn,
                              decoration:  InputDecoration(
                                  hintText: getData?.data?[0].consultancyFees.toString()??'',hintStyle: const TextStyle(fontFamily: "Montserrat"),
                                  //   fillColor: Colors.indigo[100] ,
                                  //filled: true,
                                  prefixIcon:  const Icon(Icons.currency_rupee),
                                  border: InputBorder.none
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(10), ),
                              ),
                              validator: (value) {
                                if ( value!.isEmpty) {
                                  return "Please Enter counsentency fees";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 60,
                        ),
                        Card(
                          elevation: 3,
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColorrs.white),
                            child: TextFormField(
                              controller: clinicname,
                              decoration:  InputDecoration(
                                  hintText: getData?.data?[0].clinicName.toString()??'',hintStyle: const TextStyle(fontFamily: "Montserrat"),
                                  //   fillColor: Colors.indigo[100] ,
                                  //filled: true,
                                  prefixIcon:  const Icon(Icons.person),
                                  border: InputBorder.none
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(10), ),
                              ),
                              validator: (value) {
                                if ( value!.isEmpty) {
                                  return "Please Enter description";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 60,
                        ),
                        Card(
                          elevation: 3,
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColorrs.white),
                            child: TextFormField(
                              controller: opentimecn,
                              decoration:  InputDecoration(
                                  hintText: "${getData?.data?[0].openTime.toString()??''}",hintStyle: TextStyle(fontFamily: "Montserrat"),
                                  //   fillColor: Colors.indigo[100] ,
                                  //filled: true,
                                  prefixIcon:  Icon(Icons.watch_later_rounded),
                                  border: InputBorder.none
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(10), ),
                              ),
                              validator: (value) {
                                if ( value!.isEmpty) {
                                  return "Please Select Start Time";
                                }
                                return null;
                              },
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
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 60,
                        ),
                        Card(
                          elevation: 3,
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColorrs.white),
                            child: TextFormField(
                              controller: closetimecn,
                              decoration:  InputDecoration(
                                  hintText: getData?.data?[0].openTime.toString()??'',hintStyle: const TextStyle(fontFamily: "Montserrat"),
                                  //   fillColor: Colors.indigo[100] ,
                                  //filled: true,
                                  prefixIcon:  const Icon(Icons.watch_later_rounded),
                                  border: InputBorder.none
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(10), ),
                              ),
                              validator: (value) {
                                if ( value!.isEmpty) {
                                  return "Please Select End Time";
                                }
                                return null;
                              },
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: selectedTime1,
                                ).then((value) {
                                  setState(() {
                                    selectedTime1 = value!;
                                    closetimecn.text = selectedTime1.format(context).toString();
                                  });
                                });
                              },
                            ),
                          ),
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
                        updateUserdata();
                    // if(_formKey.currentState!.validate()){
                    //   // Navigator.pushNamed(context, "support");
                    // }
                  },
                      child: const CustomButton(name: 'Update'),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 90
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> updateUserdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? doctor_id = preferences.getString('doctor_id');
  var headers = {
    'Cookie': 'ci_session=ed91b75e226ea8998ee9f938d08ec7f1c6f967ed'
  };
  var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_vet_app/seller/app/v1/api/update_doctor_profile'));
  request.fields.addAll({
  'name': namecn.text.toString(),
  'email': getData?.data?[0].email.toString()??'',
  'password': '12345678',
  'mobile': getData?.data?[0].mobile.toString()??'',
  'gender': gendercn.text.toString(),
  'experience': exprincecn.text,
  'country_code': '+91',
  'consultancy_fees': consentencycn.text,
  'open_time': opentimecn.text,
  'close_time': closetimecn.text,
  'service_type': '1',
  'store_description': 'New Clinic',
  'latitute': '22.7468891',
  'longtitute': '75.8980215',
  'clinic_address': cliniaddcn.text,
  'clinic_Name': clinicname.text,
  'Qualification': 'PG',
  'Schedule_Time': 'Monday,Wednesday,Thursday',
  'doctor_id': doctor_id.toString()
  });
  if(imageFile!=null){
  request.files.add(await http.MultipartFile.fromPath('image',imageFile!.path ));
  }
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  print('========${request.url}');
   print('=============${request.fields}');
  if (response.statusCode == 200) {
  var result =await response.stream.bytesToString();

  var finalresult=jsonDecode(result);
  if(finalresult['error'] == false){
    Fluttertoast.showToast(msg:finalresult['message']);
    // Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
  else{
    Fluttertoast.showToast(msg:finalresult['message']);
  }
  }
  else {
  print(response.reasonPhrase);
  }
}


  File? imageFile;
  File? petImage;

  // _getFromGallery() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = File(pickedFile.path);
  //     });
  //     Navigator.pop(context);
  //   }
  // }

  // _getFromCamera() async {
  //   PickedFile? pickedFile = await ImagePicker().pickImage(
  //     source: ImageSource.camera,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = File(pickedFile.path);
  //     });
  //     Navigator.pop(context);
  //   }
  // }



  Future<void> pickImage(ImageSource source, String type) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxHeight: 100,
      maxWidth: 100,
      imageQuality: 50, // You can adjust the image quality here
    );
    if (pickedFile!= null) {
      setState(() {
        if (type == 'userImage') {
          imageFile = File(pickedFile.path);
        }
      });
    }
  }
  Future<bool> showExitPopup(String type) async {
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
                pickImage(ImageSource.camera, type);
                // _getFromCamera();
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
                pickImage(ImageSource.gallery, type);
                // _getFromGallery();
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
      'user_id': "${doctor_id.toString()}"
    });
    print("doctor id iss ${request.fields}");
    request.headers.addAll(headers);
    print('=======${request.url}');
    print('===========${request.fields}');
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data=await response.stream.bytesToString();
      var finalresult=GetData.fromJson(json.decode(data));

      setState(() {
        wallet_balance = getData?.data?[0].balance.toString();
        preferences.setString('wallet_balance', wallet_balance ?? "");
        getData=finalresult;

        setState(() {


        });
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }



}
