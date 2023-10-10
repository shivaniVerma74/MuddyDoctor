import 'dart:convert';
import 'dart:io';

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

  uploadPrescription() async{
    var headers = {
      'Cookie': 'ci_session=d34a8b1f06131e2310eaa2ce3ca1534b1151a787'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_vet_app/seller/app/v1/api/upload_prescription'));
    request.fields.addAll({
      'booking_id': '${widget.model?.id}',
      'prescription_description': '${descriptioncn.text}'
    });
    request.files.add(await http.MultipartFile.fromPath('prescription', imageFile?.path ?? ""));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalResponse);
      Fluttertoast.showToast(msg: "Prescription Upload Successfully");
      Navigator.pop(context);
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
        title: const Text("Appointment Details", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child:Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height/55,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 150,
                              width: 150,
                              child:Image.network('${widget.model?.image}',fit: BoxFit.fill,)
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text('Pet Name',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                  SizedBox(height: 8),
                                  Text('${widget.model?.petName}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                  SizedBox(height: 20),
                                  Text('Pet Type',overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                  SizedBox(height: 8),
                                  Text('${widget.model?.petType}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text('${widget.model?.doctorName}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const Text('Feedbacks',style: TextStyle(color: Colors.grey,fontSize: 14),),
                                // SizedBox(height: 10,),
                                // Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       Row(
                                //         children: [
                                //           Icon(Icons.star,color: Colors.amber,),
                                //           Text('${widget.model?.rating}',style: TextStyle(color:Colors.amber),),
                                //         ],
                                //       ),
                                //     ]),
                                SizedBox(height:30),
                                Row(
                                  children: [
                                    Container(
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children:  [
                                          Text('Availibilty',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                          SizedBox(height: 10,),
                                          Text('${widget.model?.createdAt}',style: TextStyle(color: Colors.black,fontSize: 13),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('About',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                        SizedBox(height: 10,),
                        SizedBox(
                          height: 30,
                          child: Text("${widget.model?.description}",style: TextStyle(),overflow: TextOverflow.ellipsis,maxLines: 3,),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const Text(
                           "Remark",
                           style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                         ),
                         SizedBox(
                           height: MediaQuery.of(context).size.height *.01,
                         ),
                         Container(
                           height: 100,
                           child: TextFormField(
                               keyboardType: TextInputType.text,
                               controller: descriptioncn,
                               decoration: InputDecoration(
                                   hintText: '',
                                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
                         ),
                       ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Color(0xFF1F61AC)),
                      onPressed: () {
                        showExitPopup();
                      },
                      child: const Text("Upload Prescription"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  imageFile == null ? SizedBox.shrink(): InkWell(
                    onTap: () {
                      showExitPopup();
                    },
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Image.file(imageFile!,fit: BoxFit.fill,),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Color(0xFF1F61AC)),
                      onPressed: () {
                        uploadPrescription();
                      },
                      child: const Text("Submit"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final picker = ImagePicker();

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
     // Navigator.pop(context);
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
      //Navigator.pop(context);
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
                _getFromGallery();
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
    // ??false; //if showDialouge had returned null, then return false
  }
}
