import 'dart:convert';
import 'package:doctor_app/Api.pth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'  as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/GetBookingModel.dart';
import '../MyAppointments.dart';
import 'BookingDetails.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
void initState() {
    // TODO: implement initState
    super.initState();
    getBookings();
  }

  GetBookingModel? getBookingModel;
  getBookings() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? doctor_id = preferences.getString('doctor_id');
    var headers = {
      'Cookie': 'ci_session=e0b1e4e5bfdbe304c355ea816eec9806b45369b5'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getBooking));
    request.fields.addAll({
      'dr_id': doctor_id.toString()
    });
   print("doctor id in home page ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetBookingModel.fromJson(json.decode(finalResponse));
      setState(() {
        getBookingModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  updateStatus(index, int status) async {
    var headers = {
      'Cookie': 'ci_session=b337105de2900d503651f684adc7380b739a9adc'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_vet_app/seller/app/v1/api/update_status_booking'));
    request.fields.addAll({
      'booking_id': '${getBookingModel?.data?[index].id}',
      'status': status.toString()
    });
    print("update status parra ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalResponse);
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Account(),));
        },
    icon: Icon(Icons.menu),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF1F61AC),
        title: const Text("My Appointments",style: TextStyle(fontSize: 18,fontFamily: "Montserrat"),),

      ),

      body: SingleChildScrollView(
        child: getBookingModel!.error == true ? const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Center(child: Text("No Bookings Found!", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),)),
        ):
        Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: getBookingModel?.data?.length == null || getBookingModel?.data?.length == "" ? Container(
                  height: MediaQuery.of(context).size.height/1.2,
                  child: const Center(child: CircularProgressIndicator(color: Color(0xFF1F61AC)))):
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: getBookingModel?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return
                    InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetails(model: getBookingModel?.data?[index])));
                      },
                      child: Column(
                        children: [
                          Card(
                          elevation: 5,
                          child: Container(
                            //height: 200,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child:
                              Row(
                                //crossAxisAlignment: CrossAxisAlignment.end,
                                children: [

                                  Container(
                                    height: 100,
                                    width: 100,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: getBookingModel?.data?[index].image == null || getBookingModel?.data?[index].image == "" ?
                                      Image.asset("assets/images/doctor2.jpg", fit: BoxFit.fill):
                                      Image.network(
                                        "https://developmentalphawizz.com/dr_vet_app/${getBookingModel?.data?[index].image}",
                                        height: 100,
                                        width: 100,
                                        // fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                          const Text("Pet Parent’s Name: ", style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,fontFamily: "Montserrat"
                                          ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/5,
                                            child: Text(
                                              "${getBookingModel?.data?[index].doctorName??''}",
                                              style: const TextStyle(
                                                  fontSize: 12, fontWeight: FontWeight.w400,fontFamily: "Montserrat"),
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
                                              width: MediaQuery.of(context).size.width/2.6,
                                              child: Text(
                                                "${getBookingModel?.data?[index].petName??''}",

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
                                              width: MediaQuery.of(context).size.width/2.6,
                                              child:

                                              Text(
                                               "${getBookingModel?.data?[index].petType??''}",

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

                                            SizedBox(
                                              width: MediaQuery.of(context).size.width/3.6,
                                              child:

                                              const Text(
                                                "Reason for Consultation: ",

                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),

                                            SizedBox(
                                              width: MediaQuery.of(context).size.width/4,
                                              child:

                                              Text(
                                                "${getBookingModel?.data?[index].petName??''}",

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
                                                 getBookingModel?.data?[index].date??'',

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
                                              child: Text(
                                                getBookingModel?.data?[index].timeSlot??'',
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
                                          height: 15,
                                        ),
                                        getBookingModel?.data?[index].status == '0' && !(getBookingModel?.data?[index].isAccept ?? true)?
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                getBookingModel?.data?[index].isAccept = true;
                                                setState(() {});
                                                updateStatus(index, 1);
                                                },
                                              child: Container(
                                                height: 30,
                                                width: MediaQuery.of(context).size.width/3.6,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color(0xFF1F61AC)),
                                                // width: MediaQuery.of(context).size.width,
                                                child: const Center(
                                                  child: Text("Mark Complete", style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500, color: Colors.white,fontFamily: "Montserrat"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                             const SizedBox(width: 5),
                                             InkWell(
                                               onTap: () {
                                                 Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetails(model: getBookingModel?.data?[index])));
                                               },
                                               child: Container(
                                                 height: 30,
                                                 width: MediaQuery.of(context).size.width/3.6,
                                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xFF1F61AC)),
                                                 child: const Center(
                                                   child: Text("Enter Remarks", style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500, color: Colors.white,fontFamily: "Montserrat")),
                                                 ),
                                               ),
                                             ),
                                          ],
                                        ):
                                        getBookingModel?.data?[index].status == '1'||( getBookingModel?.data?[index].isAccept ?? false)?
                                        Container(
                                          height: 30,
                                          width: MediaQuery.of(context).size.width/3.7,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xFF1F61AC)),
                                          // width: MediaQuery.of(context).size.width,
                                          child: const Center(
                                            child: Text("Completed", style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500, color: Colors.white,fontFamily: "Montserrat"),
                                            ),
                                          ),
                                        ):
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        getBookingModel?.data?[index].status == '3'?
                                        Container(
                                          height: 30,
                                          width: 70,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xFF1F61AC)),
                                          // width: MediaQuery.of(context).size.width,
                                          child: const Center(
                                            child: Text("Completed", style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500, color: Colors.white,fontFamily: "Montserrat"),
                                            ),
                                          ),
                                        ):
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),
                          ),
                        ],
                      ),
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
