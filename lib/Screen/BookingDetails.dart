import 'dart:convert';
import 'dart:io';

import 'package:doctor_app/Screen/Homescreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../Model/GetBookingModel.dart';

class BookingDetails extends StatefulWidget {
  final Data? model;
  const BookingDetails({Key? key, this.model}) : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  TextEditingController descriptioncn = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  uploadPrescription() async{
    var headers = {
      'Cookie': 'ci_session=d34a8b1f06131e2310eaa2ce3ca1534b1151a787'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_vet_app/seller/app/v1/api/upload_prescription'));
    request.fields.addAll({
      'booking_id': '${widget.model?.id}',
      'prescription_description': descriptioncn.text
    });


    if(imageFile?.path!=null||imageFile?.path=='') {
      request.files.add(await http.MultipartFile.fromPath(
          'prescription', imageFile?.path ?? ""));
    }

    print(request.fields);
    print(request.url);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalResponse);
      if(jsonresponse['error'] == false)
        {
          Fluttertoast.showToast(msg: jsonresponse['message']);
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
    else{
        Fluttertoast.showToast(msg: jsonresponse['message']);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text("Appointment Details", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500,fontFamily: "Montserrat"),),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
             // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("Pet Parent’s Name: ", style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                            ,fontFamily: "Montserrat"
                        ),
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width/2.5,
                          child: Text(
                            "${widget.model?.doctorName??''}",
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,fontFamily: "Montserrat"),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text("Pet Name: ", style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/2.5,
                          child: Text(
                            "${widget.model?.petName??''}",

                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                                ,fontFamily: "Montserrat"

                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text("Pet Type: ", style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,fontFamily: "Montserrat")

                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/2.5,
                          child:

                          Text(
                            "${widget.model?.petType??''}",

                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,fontFamily: "Montserrat"),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [

                        Text(
                          "Reason for Consultation: ",

                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width/3,
                          child:

                          Text(
                            "${widget.model?.petName??''}",

                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,fontFamily: "Montserrat"),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text("Date: ", style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/3,
                          child:

                          Text(
                            "${widget.model?.date??''}",

                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,fontFamily: "Montserrat"),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text("Time: ", style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/4,
                          child:

                          Text(
                            "${widget.model?.timeSlot??''}",

                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,fontFamily: "Montserrat"),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Container(
                //   color: Colors.white,
                //   padding: const EdgeInsets.all(10),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                //     children: [
                //
                //
                //
                //
                //
                //       SizedBox(
                //         height: MediaQuery.of(context).size.height/55,
                //       ),
                //       Row(
                //         children: [
                //           Container(
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(20),
                //             ),
                //             height: 150,
                //             width: 150,
                //             child:Image.network('${widget.model?.image}',fit: BoxFit.fill,)
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 50),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children:  [
                //                 Text('Pet Name',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "Montserrat"),),
                //                 SizedBox(height: 8),
                //                 Text('${widget.model?.petName}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "Montserrat"),),
                //                 SizedBox(height: 20),
                //                 Text('Pet Type',overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "Montserrat")),
                //                 SizedBox(height: 8),
                //                 Text('${widget.model?.petType}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "Montserrat")),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Container(
                //             padding: EdgeInsets.all(10),
                //             child: Text('${widget.model?.doctorName}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,fontFamily: "Montserrat"),),
                //           ),
                //           Column(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               // const Text('Feedbacks',style: TextStyle(color: Colors.grey,fontSize: 14),),
                //               // SizedBox(height: 10,),
                //               // Row(
                //               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               //     crossAxisAlignment: CrossAxisAlignment.start,
                //               //     children: [
                //               //       Row(
                //               //         children: [
                //               //           Icon(Icons.star,color: Colors.amber,),
                //               //           Text('${widget.model?.rating}',style: TextStyle(color:Colors.amber),),
                //               //         ],
                //               //       ),
                //               //     ]),
                //               SizedBox(height:30),
                //               Row(
                //                 children: [
                //                   Container(
                //                     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                //                       children:  [
                //                         Text('Availibilty',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "Montserrat"),),
                //                         SizedBox(height: 10,),
                //                         Text('${widget.model?.createdAt}',style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "Montserrat"),),
                //                       ],
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),


                // Container(
                //   color: Colors.white,
                //   padding: EdgeInsets.all(10),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('About',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                //       SizedBox(height: 10,),
                //       SizedBox(
                //         height: 30,
                //         child: Text("${widget.model?.description}",style: TextStyle(),overflow: TextOverflow.ellipsis,maxLines: 3,),
                //       )
                //     ],
                //   ),
                // ),


                SizedBox(height: 20,),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const Text(
                       "Enter Remarks",
                       style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "Montserrat"),
                     ),
                     SizedBox(
                       height: MediaQuery.of(context).size.height *.01,
                     ),
                     Card(
                     elevation: 2,
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                           height: 100,
                           child: Form(
                             key: _formKey,
                             child: TextFormField(
                               maxLines: 3,
                                 keyboardType: TextInputType.text,
                                 controller: descriptioncn,
                                 decoration: const InputDecoration(

                                     hintText: 'Write start from here ....',hintStyle: TextStyle(fontSize: 12,fontFamily: "Montserrat"),
                                     //border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                                   border: InputBorder.none,

                                 ),
                               validator: (value) {
                                 if (value == null || value.isEmpty) {
                                   return 'Please enter some text';
                                 }
                                 return null;
                               },
                             ),
                           ),
                         ),
                       ),
                     ),
                   ],
                ),
                const SizedBox(height: 10),

                imageFile == null ? SizedBox.shrink(): InkWell(
                  onTap: () {
                    showExitPopup("userImage");
                  },
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(image: FileImage(imageFile!),fit: BoxFit.fill)),
                    // ),
                    // width: double.infinity,
                    // margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    // child: Image.file(imageFile!,fit: BoxFit.fill,),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: const Color(0xFF1F61AC)),
                    onPressed: () {
                      showExitPopup("userImage");
                    },
                    child: const Text("Upload Prescription(Optional)",style: TextStyle(fontSize: 12,fontFamily: "Montserrat",fontWeight: FontWeight.bold),),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xFF1F61AC)),
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        uploadPrescription();
                      }
                    },
                    child: const Text("Submit",style: TextStyle(fontSize: 12,fontFamily: "Montserrat",fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final picker = ImagePicker();

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
  //
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
  //
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
    if (pickedFile != null) {
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
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.camera_alt,color: Colors.white,),
                  SizedBox(width: 10),
                  Text('Image from Camera'),
                ],
              ),
            ),
            SizedBox(height: 15),
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
}
