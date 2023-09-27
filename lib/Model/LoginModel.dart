/// error : false
/// message : "Your acount is deactivated"
/// data : [{"id":"743","user_id":"743","slug":null,"category_ids":null,"cat_type":null,"store_name":null,"store_description":null,"logo":"https://developmentalphawizz.com/dr_vet_app/","store_url":null,"no_of_ratings":"0","rating":"0.00","bank_name":null,"open_time":null,"close_time":null,"bank_code":null,"account_name":null,"account_number":null,"national_identity_card":"https://developmentalphawizz.com/dr_vet_app/","address_proof":"https://developmentalphawizz.com/dr_vet_app/","pan_number":null,"tax_name":null,"tax_number":null,"permissions":null,"commission":"0.00","status":"0","date_added":"2023-09-23 12:36:10","ip_address":"152.58.57.242","username":"sachin","email":"s1@gmail.com","mobile":"8888888881","image":"https://developmentalphawizz.com/dr_vet_app/assets/no-image.png","balance":"0","activation_selector":"f8aaa6387a443aa0e38b","activation_code":"$2y$10$MRDD92CMFJGAdIDK21Dpf.hXhRCWWtdMWMSpCBREQLu8/0u8wtHhy","forgotten_password_selector":"","forgotten_password_code":"","forgotten_password_time":"","remember_selector":"","remember_code":"","created_on":"1695452770","last_login":"1695471413","active":"1","company":"","address":"","bonus":"","cash_received":"0.00","dob":"","country_code":"91","city":"283","area":"","street":"","pincode":"","apikey":"","referral_code":"","friends_code":"","fcm_id":"","latitude":"","longitude":"","created_at":"2023-09-23 12:36:10"},{"id":"111","user_id":"743","slug":null,"category_ids":null,"cat_type":null,"store_name":null,"store_description":null,"logo":"","store_url":null,"no_of_ratings":"0","rating":"0.00","bank_name":null,"open_time":null,"close_time":null,"bank_code":null,"account_name":null,"account_number":null,"national_identity_card":null,"address_proof":"","pan_number":null,"tax_name":null,"tax_number":null,"permissions":null,"commission":"0.00","status":"0","date_added":"2023-09-23 12:36:10"}]

class LoginModel {
  LoginModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  LoginModel.fromJson(dynamic json) {
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
LoginModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => LoginModel(  error: error ?? _error,
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

/// id : "743"
/// user_id : "743"
/// slug : null
/// category_ids : null
/// cat_type : null
/// store_name : null
/// store_description : null
/// logo : "https://developmentalphawizz.com/dr_vet_app/"
/// store_url : null
/// no_of_ratings : "0"
/// rating : "0.00"
/// bank_name : null
/// open_time : null
/// close_time : null
/// bank_code : null
/// account_name : null
/// account_number : null
/// national_identity_card : "https://developmentalphawizz.com/dr_vet_app/"
/// address_proof : "https://developmentalphawizz.com/dr_vet_app/"
/// pan_number : null
/// tax_name : null
/// tax_number : null
/// permissions : null
/// commission : "0.00"
/// status : "0"
/// date_added : "2023-09-23 12:36:10"
/// ip_address : "152.58.57.242"
/// username : "sachin"
/// email : "s1@gmail.com"
/// mobile : "8888888881"
/// image : "https://developmentalphawizz.com/dr_vet_app/assets/no-image.png"
/// balance : "0"
/// activation_selector : "f8aaa6387a443aa0e38b"
/// activation_code : "$2y$10$MRDD92CMFJGAdIDK21Dpf.hXhRCWWtdMWMSpCBREQLu8/0u8wtHhy"
/// forgotten_password_selector : ""
/// forgotten_password_code : ""
/// forgotten_password_time : ""
/// remember_selector : ""
/// remember_code : ""
/// created_on : "1695452770"
/// last_login : "1695471413"
/// active : "1"
/// company : ""
/// address : ""
/// bonus : ""
/// cash_received : "0.00"
/// dob : ""
/// country_code : "91"
/// city : "283"
/// area : ""
/// street : ""
/// pincode : ""
/// apikey : ""
/// referral_code : ""
/// friends_code : ""
/// fcm_id : ""
/// latitude : ""
/// longitude : ""
/// created_at : "2023-09-23 12:36:10"

class Data {
  Data({
      String? id, 
      String? userId, 
      dynamic slug, 
      dynamic categoryIds, 
      dynamic catType, 
      dynamic storeName, 
      dynamic storeDescription, 
      String? logo, 
      dynamic storeUrl, 
      String? noOfRatings, 
      String? rating, 
      dynamic bankName, 
      dynamic openTime, 
      dynamic closeTime, 
      dynamic bankCode, 
      dynamic accountName, 
      dynamic accountNumber, 
      String? nationalIdentityCard, 
      String? addressProof, 
      dynamic panNumber, 
      dynamic taxName, 
      dynamic taxNumber, 
      dynamic permissions, 
      String? commission, 
      String? status, 
      String? dateAdded, 
      String? ipAddress, 
      String? username, 
      String? email, 
      String? mobile, 
      String? image, 
      String? balance, 
      String? activationSelector, 
      String? activationCode, 
      String? forgottenPasswordSelector, 
      String? forgottenPasswordCode, 
      String? forgottenPasswordTime, 
      String? rememberSelector, 
      String? rememberCode, 
      String? createdOn, 
      String? lastLogin, 
      String? active, 
      String? company, 
      String? address, 
      String? bonus, 
      String? cashReceived, 
      String? dob, 
      String? countryCode, 
      String? city, 
      String? area, 
      String? street, 
      String? pincode, 
      String? apikey, 
      String? referralCode, 
      String? friendsCode, 
      String? fcmId, 
      String? latitude, 
      String? longitude, 
      String? createdAt,}){
    _id = id;
    _userId = userId;
    _slug = slug;
    _categoryIds = categoryIds;
    _catType = catType;
    _storeName = storeName;
    _storeDescription = storeDescription;
    _logo = logo;
    _storeUrl = storeUrl;
    _noOfRatings = noOfRatings;
    _rating = rating;
    _bankName = bankName;
    _openTime = openTime;
    _closeTime = closeTime;
    _bankCode = bankCode;
    _accountName = accountName;
    _accountNumber = accountNumber;
    _nationalIdentityCard = nationalIdentityCard;
    _addressProof = addressProof;
    _panNumber = panNumber;
    _taxName = taxName;
    _taxNumber = taxNumber;
    _permissions = permissions;
    _commission = commission;
    _status = status;
    _dateAdded = dateAdded;
    _ipAddress = ipAddress;
    _username = username;
    _email = email;
    _mobile = mobile;
    _image = image;
    _balance = balance;
    _activationSelector = activationSelector;
    _activationCode = activationCode;
    _forgottenPasswordSelector = forgottenPasswordSelector;
    _forgottenPasswordCode = forgottenPasswordCode;
    _forgottenPasswordTime = forgottenPasswordTime;
    _rememberSelector = rememberSelector;
    _rememberCode = rememberCode;
    _createdOn = createdOn;
    _lastLogin = lastLogin;
    _active = active;
    _company = company;
    _address = address;
    _bonus = bonus;
    _cashReceived = cashReceived;
    _dob = dob;
    _countryCode = countryCode;
    _city = city;
    _area = area;
    _street = street;
    _pincode = pincode;
    _apikey = apikey;
    _referralCode = referralCode;
    _friendsCode = friendsCode;
    _fcmId = fcmId;
    _latitude = latitude;
    _longitude = longitude;
    _createdAt = createdAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _slug = json['slug'];
    _categoryIds = json['category_ids'];
    _catType = json['cat_type'];
    _storeName = json['store_name'];
    _storeDescription = json['store_description'];
    _logo = json['logo'];
    _storeUrl = json['store_url'];
    _noOfRatings = json['no_of_ratings'];
    _rating = json['rating'];
    _bankName = json['bank_name'];
    _openTime = json['open_time'];
    _closeTime = json['close_time'];
    _bankCode = json['bank_code'];
    _accountName = json['account_name'];
    _accountNumber = json['account_number'];
    _nationalIdentityCard = json['national_identity_card'];
    _addressProof = json['address_proof'];
    _panNumber = json['pan_number'];
    _taxName = json['tax_name'];
    _taxNumber = json['tax_number'];
    _permissions = json['permissions'];
    _commission = json['commission'];
    _status = json['status'];
    _dateAdded = json['date_added'];
    _ipAddress = json['ip_address'];
    _username = json['username'];
    _email = json['email'];
    _mobile = json['mobile'];
    _image = json['image'];
    _balance = json['balance'];
    _activationSelector = json['activation_selector'];
    _activationCode = json['activation_code'];
    _forgottenPasswordSelector = json['forgotten_password_selector'];
    _forgottenPasswordCode = json['forgotten_password_code'];
    _forgottenPasswordTime = json['forgotten_password_time'];
    _rememberSelector = json['remember_selector'];
    _rememberCode = json['remember_code'];
    _createdOn = json['created_on'];
    _lastLogin = json['last_login'];
    _active = json['active'];
    _company = json['company'];
    _address = json['address'];
    _bonus = json['bonus'];
    _cashReceived = json['cash_received'];
    _dob = json['dob'];
    _countryCode = json['country_code'];
    _city = json['city'];
    _area = json['area'];
    _street = json['street'];
    _pincode = json['pincode'];
    _apikey = json['apikey'];
    _referralCode = json['referral_code'];
    _friendsCode = json['friends_code'];
    _fcmId = json['fcm_id'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _userId;
  dynamic _slug;
  dynamic _categoryIds;
  dynamic _catType;
  dynamic _storeName;
  dynamic _storeDescription;
  String? _logo;
  dynamic _storeUrl;
  String? _noOfRatings;
  String? _rating;
  dynamic _bankName;
  dynamic _openTime;
  dynamic _closeTime;
  dynamic _bankCode;
  dynamic _accountName;
  dynamic _accountNumber;
  String? _nationalIdentityCard;
  String? _addressProof;
  dynamic _panNumber;
  dynamic _taxName;
  dynamic _taxNumber;
  dynamic _permissions;
  String? _commission;
  String? _status;
  String? _dateAdded;
  String? _ipAddress;
  String? _username;
  String? _email;
  String? _mobile;
  String? _image;
  String? _balance;
  String? _activationSelector;
  String? _activationCode;
  String? _forgottenPasswordSelector;
  String? _forgottenPasswordCode;
  String? _forgottenPasswordTime;
  String? _rememberSelector;
  String? _rememberCode;
  String? _createdOn;
  String? _lastLogin;
  String? _active;
  String? _company;
  String? _address;
  String? _bonus;
  String? _cashReceived;
  String? _dob;
  String? _countryCode;
  String? _city;
  String? _area;
  String? _street;
  String? _pincode;
  String? _apikey;
  String? _referralCode;
  String? _friendsCode;
  String? _fcmId;
  String? _latitude;
  String? _longitude;
  String? _createdAt;
Data copyWith({  String? id,
  String? userId,
  dynamic slug,
  dynamic categoryIds,
  dynamic catType,
  dynamic storeName,
  dynamic storeDescription,
  String? logo,
  dynamic storeUrl,
  String? noOfRatings,
  String? rating,
  dynamic bankName,
  dynamic openTime,
  dynamic closeTime,
  dynamic bankCode,
  dynamic accountName,
  dynamic accountNumber,
  String? nationalIdentityCard,
  String? addressProof,
  dynamic panNumber,
  dynamic taxName,
  dynamic taxNumber,
  dynamic permissions,
  String? commission,
  String? status,
  String? dateAdded,
  String? ipAddress,
  String? username,
  String? email,
  String? mobile,
  String? image,
  String? balance,
  String? activationSelector,
  String? activationCode,
  String? forgottenPasswordSelector,
  String? forgottenPasswordCode,
  String? forgottenPasswordTime,
  String? rememberSelector,
  String? rememberCode,
  String? createdOn,
  String? lastLogin,
  String? active,
  String? company,
  String? address,
  String? bonus,
  String? cashReceived,
  String? dob,
  String? countryCode,
  String? city,
  String? area,
  String? street,
  String? pincode,
  String? apikey,
  String? referralCode,
  String? friendsCode,
  String? fcmId,
  String? latitude,
  String? longitude,
  String? createdAt,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  slug: slug ?? _slug,
  categoryIds: categoryIds ?? _categoryIds,
  catType: catType ?? _catType,
  storeName: storeName ?? _storeName,
  storeDescription: storeDescription ?? _storeDescription,
  logo: logo ?? _logo,
  storeUrl: storeUrl ?? _storeUrl,
  noOfRatings: noOfRatings ?? _noOfRatings,
  rating: rating ?? _rating,
  bankName: bankName ?? _bankName,
  openTime: openTime ?? _openTime,
  closeTime: closeTime ?? _closeTime,
  bankCode: bankCode ?? _bankCode,
  accountName: accountName ?? _accountName,
  accountNumber: accountNumber ?? _accountNumber,
  nationalIdentityCard: nationalIdentityCard ?? _nationalIdentityCard,
  addressProof: addressProof ?? _addressProof,
  panNumber: panNumber ?? _panNumber,
  taxName: taxName ?? _taxName,
  taxNumber: taxNumber ?? _taxNumber,
  permissions: permissions ?? _permissions,
  commission: commission ?? _commission,
  status: status ?? _status,
  dateAdded: dateAdded ?? _dateAdded,
  ipAddress: ipAddress ?? _ipAddress,
  username: username ?? _username,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  image: image ?? _image,
  balance: balance ?? _balance,
  activationSelector: activationSelector ?? _activationSelector,
  activationCode: activationCode ?? _activationCode,
  forgottenPasswordSelector: forgottenPasswordSelector ?? _forgottenPasswordSelector,
  forgottenPasswordCode: forgottenPasswordCode ?? _forgottenPasswordCode,
  forgottenPasswordTime: forgottenPasswordTime ?? _forgottenPasswordTime,
  rememberSelector: rememberSelector ?? _rememberSelector,
  rememberCode: rememberCode ?? _rememberCode,
  createdOn: createdOn ?? _createdOn,
  lastLogin: lastLogin ?? _lastLogin,
  active: active ?? _active,
  company: company ?? _company,
  address: address ?? _address,
  bonus: bonus ?? _bonus,
  cashReceived: cashReceived ?? _cashReceived,
  dob: dob ?? _dob,
  countryCode: countryCode ?? _countryCode,
  city: city ?? _city,
  area: area ?? _area,
  street: street ?? _street,
  pincode: pincode ?? _pincode,
  apikey: apikey ?? _apikey,
  referralCode: referralCode ?? _referralCode,
  friendsCode: friendsCode ?? _friendsCode,
  fcmId: fcmId ?? _fcmId,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  createdAt: createdAt ?? _createdAt,
);
  String? get id => _id;
  String? get userId => _userId;
  dynamic get slug => _slug;
  dynamic get categoryIds => _categoryIds;
  dynamic get catType => _catType;
  dynamic get storeName => _storeName;
  dynamic get storeDescription => _storeDescription;
  String? get logo => _logo;
  dynamic get storeUrl => _storeUrl;
  String? get noOfRatings => _noOfRatings;
  String? get rating => _rating;
  dynamic get bankName => _bankName;
  dynamic get openTime => _openTime;
  dynamic get closeTime => _closeTime;
  dynamic get bankCode => _bankCode;
  dynamic get accountName => _accountName;
  dynamic get accountNumber => _accountNumber;
  String? get nationalIdentityCard => _nationalIdentityCard;
  String? get addressProof => _addressProof;
  dynamic get panNumber => _panNumber;
  dynamic get taxName => _taxName;
  dynamic get taxNumber => _taxNumber;
  dynamic get permissions => _permissions;
  String? get commission => _commission;
  String? get status => _status;
  String? get dateAdded => _dateAdded;
  String? get ipAddress => _ipAddress;
  String? get username => _username;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get image => _image;
  String? get balance => _balance;
  String? get activationSelector => _activationSelector;
  String? get activationCode => _activationCode;
  String? get forgottenPasswordSelector => _forgottenPasswordSelector;
  String? get forgottenPasswordCode => _forgottenPasswordCode;
  String? get forgottenPasswordTime => _forgottenPasswordTime;
  String? get rememberSelector => _rememberSelector;
  String? get rememberCode => _rememberCode;
  String? get createdOn => _createdOn;
  String? get lastLogin => _lastLogin;
  String? get active => _active;
  String? get company => _company;
  String? get address => _address;
  String? get bonus => _bonus;
  String? get cashReceived => _cashReceived;
  String? get dob => _dob;
  String? get countryCode => _countryCode;
  String? get city => _city;
  String? get area => _area;
  String? get street => _street;
  String? get pincode => _pincode;
  String? get apikey => _apikey;
  String? get referralCode => _referralCode;
  String? get friendsCode => _friendsCode;
  String? get fcmId => _fcmId;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['slug'] = _slug;
    map['category_ids'] = _categoryIds;
    map['cat_type'] = _catType;
    map['store_name'] = _storeName;
    map['store_description'] = _storeDescription;
    map['logo'] = _logo;
    map['store_url'] = _storeUrl;
    map['no_of_ratings'] = _noOfRatings;
    map['rating'] = _rating;
    map['bank_name'] = _bankName;
    map['open_time'] = _openTime;
    map['close_time'] = _closeTime;
    map['bank_code'] = _bankCode;
    map['account_name'] = _accountName;
    map['account_number'] = _accountNumber;
    map['national_identity_card'] = _nationalIdentityCard;
    map['address_proof'] = _addressProof;
    map['pan_number'] = _panNumber;
    map['tax_name'] = _taxName;
    map['tax_number'] = _taxNumber;
    map['permissions'] = _permissions;
    map['commission'] = _commission;
    map['status'] = _status;
    map['date_added'] = _dateAdded;
    map['ip_address'] = _ipAddress;
    map['username'] = _username;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['image'] = _image;
    map['balance'] = _balance;
    map['activation_selector'] = _activationSelector;
    map['activation_code'] = _activationCode;
    map['forgotten_password_selector'] = _forgottenPasswordSelector;
    map['forgotten_password_code'] = _forgottenPasswordCode;
    map['forgotten_password_time'] = _forgottenPasswordTime;
    map['remember_selector'] = _rememberSelector;
    map['remember_code'] = _rememberCode;
    map['created_on'] = _createdOn;
    map['last_login'] = _lastLogin;
    map['active'] = _active;
    map['company'] = _company;
    map['address'] = _address;
    map['bonus'] = _bonus;
    map['cash_received'] = _cashReceived;
    map['dob'] = _dob;
    map['country_code'] = _countryCode;
    map['city'] = _city;
    map['area'] = _area;
    map['street'] = _street;
    map['pincode'] = _pincode;
    map['apikey'] = _apikey;
    map['referral_code'] = _referralCode;
    map['friends_code'] = _friendsCode;
    map['fcm_id'] = _fcmId;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['created_at'] = _createdAt;
    return map;
  }

}