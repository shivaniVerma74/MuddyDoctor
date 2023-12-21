import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:doctor_app/Api.pth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
//import 'package:geolocator/geolocator.dart';
import '../Utils/CustomButton.dart';
import 'package:http/http.dart'as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'LoginScreen.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  State<Register> createState() => _RegisterState();
}
var homelat;
var homeLong;
class _RegisterState extends State<Register> with TickerProviderStateMixin{

  late TabController tabController;
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
  final TextEditingController clinicnamecn=TextEditingController();
  final TextEditingController qualificationcn=TextEditingController();
  final TextEditingController selecttimecn=TextEditingController();
  final TextEditingController docDegreeCtr = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isHidden=true;

  String? dropdownvalue="Online" ;
  var selectedService;
  var items = [
    'Online',
    'In-clinic',
    'Online and In-clinic Both',
  ];

  //String? Service_type;
  // List<String> Service_Type=['Online','InClinic','both'];

  String? gender= "Female";
  int num=1;
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTime1 = TimeOfDay.now();
  @override
  void initState(){
    super.initState();
    tabController = TabController(length: 7, vsync: this);
  }


  final List<String> daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  List<String> onSelectedWeek = [];
  var selectedWeek;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(
                height: 20
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
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                    const Text(
                      "Register Now",
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                " Set up your account by entering",
                style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
              ),
              const Text(
                " the following details.",
                style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
              ),
              const SizedBox(
                height: 20,
              ),
             Container(
               // color: Colors.red,
               height: 120,
               width: 120,
               child: CircleAvatar(
                 child: Container(
                   height: 120,
                   width: 120,
                   child: ClipRRect(
                    child: imageFile == null || imageFile == "" ?
                    Image.network('assets/images/doctor.jpg') : Image.file(imageFile!, fit: BoxFit.fill),
                   ),
                 ),
               ),
             ),
              InkWell(
                onTap: () {
                  showExitPopup("userImage");
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text("Select Image", style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontFamily: "Montserrat")),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Card(
                      elevation: 3,
                      child: TextFormField(
                        controller: namecn,
                        decoration: const InputDecoration(
                            hintText: "Name",
                            // fillColor: Colors.indigo[100] ,
                            filled: true,
                            prefixIcon: Icon(Icons.person),
                            border: InputBorder.none
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(8))
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter name";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/60,
                    ),
                    Card(
                      elevation: 3,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phonecn,
                        maxLength: 10,
                        decoration: const InputDecoration(
                            hintText: "Mobile No",
                            // fillColor: Colors.indigo[100] ,
                            filled: true,
                            counterText: '',
                            prefixIcon:  Icon(Icons.phone),
                             border: InputBorder.none
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(8))
                        ),
                        validator: (value) {
                          if ( value!.isEmpty || value.length<10) {
                            return "Please Enter Mobile no";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/60,
                    ),
                    Row(
                      children: [
                        Radio(
                          //  activeColor: Color(0xff7F62B0),
                            value: "Male",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                num = 0; gender = value.toString();
                              });
                            }),
                        const Text("Male",
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
                        const Text(
                          "Female",
                          // style: TextStyle(color: Color(0xff7F62B0)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/60,
                    ),
                    Card(
                      elevation: 3,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailcn,
                        decoration: const InputDecoration(
                            hintText: "Email",
                            // fillColor: Colors.indigo[100] ,
                            filled: true,
                            counterText: '',
                            prefixIcon: Icon(Icons.email),
                            border: InputBorder.none
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(8))
                        ),
                        validator: (value) {
                          if ( value!.isEmpty) {
                            return "Please Enter email";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/60,
                    ),
                    Card(
                      elevation: 3,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordcn,
                        obscureText: isHidden,
                        maxLength: 8,
                        decoration: InputDecoration(
                            hintText: "Password",
                            // fillColor: Colors.indigo[100] ,
                            filled: true,
                            counterText: '',
                            prefixIcon:  Icon(Icons.lock),
                            suffixIcon: InkWell(onTap: PaaswordView,
                                child: Icon(Icons.visibility)),
                        border: InputBorder.none
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(8))
                        ),

                        validator: (value) {
                          if ( value!.isEmpty||value.length<6) {
                            return "Please Enter password";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/60,
                    ),
                    Card(
                      elevation: 3,
                      child: TextFormField(
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => PlacePicker(
                        //         apiKey: Platform.isAndroid
                        //             ? "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA"
                        //             : "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
                        //         onPlacePicked: (result) {
                        //           print(result.formattedAddress);
                        //           setState(() {
                        //             clinicCtr.text = result.formattedAddress.toString();
                        //             pickLat = result.geometry!.location.lat;
                        //             pickLong = result.geometry!.location.lng;
                        //           });
                        //           Navigator.of(context).pop();
                        //           // distnce();
                        //         },
                        //         initialPosition: LatLng(currentLocation!.latitude, currentLocation!.longitude),
                        //         useCurrentLocation: true,
                        //       ),
                        //     ),
                        //   );
                        // },
                        keyboardType: TextInputType.text,
                        controller: clinicCtr,
                        decoration: const InputDecoration(
                            hintText: "Address",
                            // fillColor: Colors.indigo[100] ,
                            filled: true,
                            counterText: '',
                            prefixIcon:  Icon(Icons.location_on_sharp),
                            border: InputBorder.none
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(8))
                        ),
                        validator: (value) {
                          if ( value!.isEmpty) {
                            return "Please Enter location";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/60,
                    ),
                    Card(
                      elevation: 3,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller:exprincecn,
                        decoration: const InputDecoration(
                            hintText: "Experience in years",
                            // fillColor: Colors.indigo[100] ,
                            filled: true,
                            counterText: '',
                            prefixIcon:  Icon(Icons.person),
                               border: InputBorder.none
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(8))
                        ),

                        validator: (value) {
                          if ( value!.isEmpty) {
                            return "Please Enter experince In Year";
                          }
                          return null;
                        },
                      ),
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

                    const SizedBox(
                        height: 5
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Row(
                        children: const [
                          Text("Select Consultation Type",style: TextStyle(fontFamily: "Montserrat"),),
                        ],
                      ),
                    ),
                    const SizedBox(
                        height: 5
                    ),
                    const SizedBox(height: 5),
                    Card(
                      elevation: 3,
                      child: DropdownButtonFormField<String>(
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
                            dropdownvalue = newValue!;
                          });
                          if(dropdownvalue == "Online"){
                           setState(() {
                             selectedService = 1;
                           });
                          } else if(dropdownvalue == "In-clinic"){
                           setState(() {
                             selectedService =2;
                           });
                          } else{
                            setState(() {
                              selectedService = 3;
                            });
                          }
                          print("valuesss selectedd ${selectedService}");
                        },
                        items:items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText:
                          '  Service Type',
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    Card(
                      elevation: 3,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller:consentencycn,
                        decoration: const InputDecoration(
                            hintText: "Consultancy Fees",
                            // fillColor: Colors.indigo[100] ,
                            filled: true,
                            counterText: '',
                            prefixIcon:  Icon(Icons.currency_rupee),
                            border: InputBorder.none
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(8))
                        ),
                        validator: (value) {
                          if ( value!.isEmpty) {
                            return "Please Enter Consultancy Fees";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    Card(
                      elevation: 3,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller:storedcn,
                        decoration: const InputDecoration(
                            hintText: "Clinic/Vet Description",
                            // fillColor: Colors.indigo[100] ,
                            filled: true,
                            counterText: '',
                            prefixIcon:  Icon(Icons.person),
                             border: InputBorder.none
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(8))
                        ),
                        validator: (value) {
                          if ( value!.isEmpty) {
                            return "Please Enter Clinic/Vet Description";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    Card(
                      elevation: 3,
                      child: TextFormField(
                        controller: opentimecn,
                        decoration: InputDecoration(
                            hintText: "Start Time",
                            // fillColor:  ,
                            filled: true,
                            prefixIcon: IconButton(
                              onPressed: () async {
                                showTimePicker(
                                  context: context,
                                  initialTime: selectedTime,
                                ).then((value) {
                                  setState(() {
                                    selectedTime = value!;
                                    opentimecn.text = selectedTime.format(context).toString();
                                  });
                                });
                              },
                              icon: const Icon(Icons.watch_later_rounded),
                            ),
                            border: InputBorder.none
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(8))
                        ),
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: selectedTime,
                          ).then((value) {
                            setState(() {
                              selectedTime = value!;
                              opentimecn.text = selectedTime.format(context).toString();
                            });
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Select Start Time";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    Card(
                      elevation: 3,
                      child: TextFormField(
                        controller: closetimecn,
                        decoration: InputDecoration(
                            hintText: "End Time",
                            // fillColor: Colors.indigo[100] ,
                            filled: true,
                            prefixIcon: IconButton(
                              onPressed: () async {
                                showTimePicker(
                                  context: context,
                                  initialTime: selectedTime1,
                                ).then((value) {
                                  setState(() {
                                    selectedTime1 = value!;
                                    opentimecn.text = selectedTime1.format(context).toString();
                                  });
                                });
                              },
                              icon: const Icon(Icons.watch_later_rounded),
                            ),
                            border: InputBorder.none
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(8))
                        ),
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
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Please Select End Time";
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    Card(
                      elevation: 3,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller:clinicnamecn,
                        decoration: const InputDecoration(
                            hintText: "Clinic Name",
                            // fillColor: Colors.indigo[100] ,
                            filled: true,
                            counterText: '',
                            prefixIcon:  Icon(Icons.person),
                           border: InputBorder.none,
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(8))
                        ),
                        validator: (value) {
                          if ( value!.isEmpty) {
                            return "Please Enter Clinic Name";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 60,
                    // ),
                    // TextFormField(
                    //   keyboardType: TextInputType.text,
                    //   controller: docDegreeCtr,
                    //   decoration: InputDecoration(
                    //       hintText: "Doctor Degree",
                    //       fillColor: Colors.indigo[100] ,
                    //       filled: true,
                    //       counterText: '',
                    //       prefixIcon:  Icon(Icons.location_on_sharp),
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8))),
                    //   validator: (value) {
                    //     if ( value!.isEmpty) {
                    //       return "Please Enter Degree";
                    //     }
                    //     return null;
                    //   },
                    // ),
                    const SizedBox(
                      height: 5
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Row(
                        children: const [
                          Text("Select Days",style: TextStyle(fontFamily: "Montserrat"),),
                        ],
                      ),
                    ),
                    const SizedBox(
                        height: 5
                    ),
                    Card(
                      elevation: 3,
                      child: Container(
                        height: 60,
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8)),
                          //height: 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: daysOfWeek.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  if(onSelectedWeek.contains(daysOfWeek[index])){
                                    onSelectedWeek.remove(daysOfWeek[index]);
                                    selectedWeek = onSelectedWeek.join(",");
                                    print("selectedd ${onSelectedWeek}");
                                  } else{
                                    onSelectedWeek.add(daysOfWeek[index]);
                                    selectedWeek = onSelectedWeek.join(",");
                                    print("selectedd@@@@@ ${onSelectedWeek}");
                                  }
                                  setState(() {});
                                },
                                child: SizedBox(
                                              height: 20,
                                              width: 120,
                                              child: Card(
                                                color: onSelectedWeek.contains(daysOfWeek[index]) ? Color(0xFF1F61AC): Colors.grey,
                                                  child: Center(child: Text(daysOfWeek[index],style: TextStyle(fontFamily: "Montserrat"),),
                                                  ),
                                              ),
                                ),
                              );
                              //   ListTile(
                              //   title:
                              // );
                            },
                          ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    Card(
                      elevation: 3,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller:qualificationcn,
                        decoration: const InputDecoration(
                            hintText: "Qualification",
                            // fillColor: Colors.indigo[100] ,
                            filled: true,
                            counterText: '',
                            prefixIcon:  Icon(Icons.school),
                            border: InputBorder.none
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(8))
                        ),
                        validator: (value) {
                          if ( value!.isEmpty) {
                            return "Please Enter Qualification";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/60,
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height/17,
              // ),

              SizedBox(
                height: MediaQuery.of(context).size.height/69,
              ),
              InkWell(
                  onTap: () async {
                    ///1st UI
                    if(_formKey.currentState!.validate()) {
                        register();
                      // Navigator.pushNamed(context, "myAppointments");
                    } ///2nd UI
                    // Navigator.pushNamed(context, "findPetStuff");
                  },
                  child: const CustomButton(name: "Continue")),
              SizedBox(
                height: MediaQuery.of(context).size.height/69,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Back to Sign In",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,fontFamily: "Montserrat"),
                  ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height / 20,
              // ),
              // const Text(
              //   "We'll send an OTP on above",
              //   style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
              // ),
              // const Text(
              //   "given phone number",
              //   style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
              // ),
              //   ElevatedButton(onPressed: (){getLocation();}, child: Text('location'))
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> openPlacePicker(BuildContext context) async {
  //   try {
  //     LocationResult result = await showPlacePicker(
  //       context, apiKey: "YOUR_API_KEY", // Replace with your Google Maps API key
  //     );
  //
  //     if (result != null) {
  //       print("Selected place: ${result.formattedAddress}");
  //       setState(() {
  //         clinicCtr.text = result.formattedAddress.toString();
  //         // pickLat = result.geometry!.location.lat;
  //         // pickLong = result.geometry!.location.lng;
  //       });
  //       Navigator.of(context).pop();
  //       // You can do something with the selected place here
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  final picker = ImagePicker();
  File? imageFile;

  // File? petImage;
  // _getFromGallery() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = File(pickedFile.path);
  //     });
  //   }
  // }
  //
  // _getFromCamera() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = File(pickedFile.path);
  //     });
  //   }
  // }

  File? userImage;
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
        title: const Text('Select Image'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                pickImage(ImageSource.camera, type);
                Navigator.pop(context);
              },
              //return false when click on "NO"
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.camera_alt,color: Colors.white,),
                  SizedBox(width: 10),
                  Text('Image from Camera'),
                ],
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                pickImage(ImageSource.gallery, type);
                Navigator.pop(context);
                // Navigator.pop(context,true);
                // Navigator.pop(context,true);
              },
              //return true when click on "Yes"
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.photo,color: Colors.white,),
                  SizedBox(width: 10),
                  Text('Image from Gallery'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double pickLat = 0;
  double pickLong = 0;
  Position? currentLocation;


  Future<void> register() async {
    var headers = {
      'Cookie': 'ci_session=1f5168f9f8d6530398df5dcac5a2d39162c175d1'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.registerUser));
    request.fields.addAll({
      'name': namecn.text,
      'email':emailcn.text,
      'password': passwordcn.text,
      'mobile': phonecn.text,
      'gender': gender.toString(),
      'experience': exprincecn.text,
      'country_code': '+91',
      'consultancy_fees': consentencycn.text,
      'open_time': opentimecn.text,
      'close_time': closetimecn.text,
      'service_type': selectedService.toString(),
      'store_description': storedcn.text,
      'latitute': '22.7468891',
      'longitude': '75.8980215',
      'clinic_address': clinicCtr.text,
      'clinic_name': clinicnamecn.text,
      'qualification': qualificationcn.text,
      'schedule_time':selectedWeek
    });
    print("register para ${request.fields}");

    if(imageFile?.path!=null||imageFile?.path=='') {

      request.files.add(await http.MultipartFile.fromPath('image', imageFile?.path ?? ""));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("statusss ${response.statusCode}");
      var result=await response.stream.bytesToString();
      var finalresult=jsonDecode(result);
      if(finalresult['error'] == false) {
        Fluttertoast.showToast(msg: "${finalresult['message']}");
        // Navigator.pushNamed(context, "myAppointments");
        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
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

