/// error : false
/// message : "Booking retrieved successfully"
/// data : [{"id":"112","user_id":"742","doctor_id":"106","pet_id":"0","description":"new booking","day":"","date":"2023-09-26","status":"0","created_at":"2023-09-25 10:35:05","updated_at":"2023-09-25 10:35:05","time_slot":"10:00:00","report":"uploads/review_image/image_picker1920515854339442714.jpg","image":"uploads/review_image/image_picker6005247528543842509.jpg","transaction_id":"TXN1235455555","payment_type":"online","doctor_name":null,"pet_type":null,"pet_name":null},{"id":"111","user_id":"742","doctor_id":"106","pet_id":"0","description":"ggcggc","day":"","date":"2023-09-23","status":"0","created_at":"2023-09-23 13:08:10","updated_at":"2023-09-23 13:08:10","time_slot":"10:00:00","report":"uploads/review_image/image_picker3527397850611440008.jpg","image":"uploads/review_image/image_picker6803241707480427191.jpg","transaction_id":"TXN1235455555","payment_type":"online","doctor_name":null,"pet_type":null,"pet_name":null},{"id":"110","user_id":"742","doctor_id":"729","pet_id":"8","description":"This is a test description","day":"","date":"2023-09-21","status":"0","created_at":"2023-09-23 12:55:25","updated_at":"2023-09-23 12:55:25","time_slot":"10:00:00","report":"","image":"","transaction_id":"TXN1235455555","payment_type":"online","doctor_name":"Dikshaya Pandey","pet_type":"Dog","pet_name":"Kitty"},{"id":"109","user_id":"731","doctor_id":"729","pet_id":"8","description":"This is a test description","day":"","date":"2023-09-21","status":"0","created_at":"2023-09-23 10:21:22","updated_at":"2023-09-23 10:21:22","time_slot":"10:00:00","report":"","image":"","transaction_id":"TXN1235455555","payment_type":"online","doctor_name":"Dikshaya Pandey","pet_type":"Dog","pet_name":"Kitty"},{"id":"108","user_id":"731","doctor_id":"729","pet_id":"8","description":"This is a test description","day":"","date":"2023-09-21","status":"0","created_at":"2023-09-22 13:00:12","updated_at":"2023-09-22 13:00:12","time_slot":"10:00:00","report":"","image":"","transaction_id":"TXN1235455555","payment_type":"online","doctor_name":"Dikshaya Pandey","pet_type":"Dog","pet_name":"Kitty"},{"id":"107","user_id":"731","doctor_id":"729","pet_id":"8","description":"This is a test description","day":"","date":"2023-09-21","status":"0","created_at":"2023-09-22 12:51:19","updated_at":"2023-09-22 12:51:19","time_slot":"10:00:00","report":"","image":"","transaction_id":"TXN1235455555","payment_type":"online","doctor_name":"Dikshaya Pandey","pet_type":"Dog","pet_name":"Kitty"},{"id":"106","user_id":"730","doctor_id":"729","pet_id":"8","description":"This is a test description","day":"","date":"2023-09-21","status":"0","created_at":"2023-09-22 12:28:57","updated_at":"2023-09-22 12:28:57","time_slot":"10:00:00","report":"","image":"","transaction_id":"TXN1235455555","payment_type":"online","doctor_name":"Dikshaya Pandey","pet_type":"Dog","pet_name":"Kitty"},{"id":"105","user_id":"730","doctor_id":"729","pet_id":"8","description":"This is a test description","day":"","date":"2023-09-21","status":"0","created_at":"2023-09-20 20:27:01","updated_at":"2023-09-20 20:27:01","time_slot":"10:00:00","report":"uploads/review_image/favicon-managemnt-track4.png","image":"uploads/review_image/logo_(1).png","transaction_id":"TXN1235455555","payment_type":"online","doctor_name":"Dikshaya Pandey","pet_type":"Dog","pet_name":"Kitty"},{"id":"104","user_id":"730","doctor_id":"729","pet_id":"8","description":"This is a test description","day":"","date":"2023-09-21","status":"0","created_at":"2023-09-20 20:26:23","updated_at":"2023-09-20 20:26:23","time_slot":"10:00:00","report":"","image":"","transaction_id":"TXN1235455555","payment_type":"online","doctor_name":"Dikshaya Pandey","pet_type":"Dog","pet_name":"Kitty"},{"id":"103","user_id":"730","doctor_id":"729","pet_id":"4","description":"frfv","day":"Sun","date":"2023-08-29","status":"1","created_at":"2023-08-29 13:21:03","updated_at":"2023-07-29 18:25:07","time_slot":"13:00:00","report":"","image":"","transaction_id":"","payment_type":"","doctor_name":"Dikshaya Pandey","pet_type":"Cat","pet_name":"Kitty"},{"id":"78","user_id":"730","doctor_id":"729","pet_id":"4","description":"frfv","day":"Sun","date":"2023-07-30","status":"1","created_at":"2023-08-29 13:18:21","updated_at":"2023-07-29 18:25:07","time_slot":"13:10:00","report":"","image":"","transaction_id":"","payment_type":"","doctor_name":"Dikshaya Pandey","pet_type":"Cat","pet_name":"Kitty"}]

class GetBookingModel {
  GetBookingModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetBookingModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
GetBookingModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetBookingModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "112"
/// user_id : "742"
/// doctor_id : "106"
/// pet_id : "0"
/// description : "new booking"
/// day : ""
/// date : "2023-09-26"
/// status : "0"
/// created_at : "2023-09-25 10:35:05"
/// updated_at : "2023-09-25 10:35:05"
/// time_slot : "10:00:00"
/// report : "uploads/review_image/image_picker1920515854339442714.jpg"
/// image : "uploads/review_image/image_picker6005247528543842509.jpg"
/// transaction_id : "TXN1235455555"
/// payment_type : "online"
/// doctor_name : null
/// pet_type : null
/// pet_name : null

class Data {
  Data({
      String? id, 
      String? userId, 
      String? doctorId, 
      String? petId, 
      String? description, 
      String? day, 
      String? date, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      String? timeSlot, 
      String? report, 
      String? image, 
      String? transactionId, 
      String? paymentType,
     bool? isAccept,
      dynamic doctorName, 
      dynamic petType, 
      dynamic petName,}){
    _id = id;
    _userId = userId;
    _doctorId = doctorId;
    _petId = petId;
    _description = description;
    _day = day;
    _date = date;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
     isAccept = isAccept;
    _timeSlot = timeSlot;
    _report = report;
    _image = image;
    _transactionId = transactionId;
    _paymentType = paymentType;
    _doctorName = doctorName;
    _petType = petType;
    _petName = petName;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _doctorId = json['doctor_id'];
    _petId = json['pet_id'];
    _description = json['description'];
    _day = json['day'];
    _date = json['date'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _timeSlot = json['time_slot'];
    _report = json['report'];
     isAccept = false;
    _image = json['image'];
    _transactionId = json['transaction_id'];
    _paymentType = json['payment_type'];
    _doctorName = json['doctor_name'];
    _petType = json['pet_type'];
    _petName = json['pet_name'];
  }
  String? _id;
  String? _userId;
  String? _doctorId;
  String? _petId;
  String? _description;
  String? _day;
  String? _date;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _timeSlot;
  String? _report;
  String? _image;
  String? _transactionId;
  String? _paymentType;
  bool? isAccept;
  dynamic _doctorName;
  dynamic _petType;
  dynamic _petName;
Data copyWith({  String? id,
  String? userId,
  String? doctorId,
  String? petId,
  String? description,
  String? day,
  String? date,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? timeSlot,
  String? report,
  String? image,
  String? transactionId,
  String? paymentType,
  dynamic doctorName,
  dynamic petType,
  dynamic petName,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  doctorId: doctorId ?? _doctorId,
  petId: petId ?? _petId,
  description: description ?? _description,
  day: day ?? _day,
  date: date ?? _date,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  timeSlot: timeSlot ?? _timeSlot,
  report: report ?? _report,
  image: image ?? _image,
  transactionId: transactionId ?? _transactionId,
  paymentType: paymentType ?? _paymentType,
  doctorName: doctorName ?? _doctorName,
  petType: petType ?? _petType,
  petName: petName ?? _petName,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get doctorId => _doctorId;
  String? get petId => _petId;
  String? get description => _description;
  String? get day => _day;
  String? get date => _date;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get timeSlot => _timeSlot;
  String? get report => _report;
  String? get image => _image;
  String? get transactionId => _transactionId;
  String? get paymentType => _paymentType;
  dynamic get doctorName => _doctorName;
  dynamic get petType => _petType;
  dynamic get petName => _petName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['doctor_id'] = _doctorId;
    map['pet_id'] = _petId;
    map['description'] = _description;
    map['day'] = _day;
    map['date'] = _date;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['time_slot'] = _timeSlot;
    map['report'] = _report;
    map['image'] = _image;
    map['transaction_id'] = _transactionId;
    map['payment_type'] = _paymentType;
    map['doctor_name'] = _doctorName;
    map['pet_type'] = _petType;
    map['pet_name'] = _petName;
    return map;
  }

}