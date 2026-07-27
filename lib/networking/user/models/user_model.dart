import 'package:constructo/networking/extensions/api_helper.dart';

class UserModel {
  int? _userId;
  String _name = "";
  String _email = "";
  String _mobile = "";
  bool _isVerified = false;
  bool _disabled = false;
  // String _role = "";
  String _createdAt = "";
  String _jwtToken = "";

  UserModel();

  UserModel.fromMap(Map data) {
    final Map user = apiPeramMap(data["user"]);
    final token = apiPeramString(data["token"]);

    // ----
    _userId = apiPeramIntId(user['id']); // for individual null
    _name = apiPeramString(user['name']);
    _email = apiPeramString(user['email']);
    _mobile = apiPeramString(user['mobile']);
    _isVerified = apiPeramBool(user['isVerified']);
    _disabled = apiPeramBool(user['disabled']);
    // _role = apiPeramString(user['role']); // for individual null
    _createdAt = apiPeramString(user['createdAt']);
    _jwtToken = token;
  }

  int? get userId => _userId;
  String get name => _name;
  String get email => _email;
  String get mobile => _mobile;
  bool get isVerified => _isVerified;
  bool get disabled => _disabled;
  // EnumUserRole get role => getUserRoleEnum(_role);
  // bool get isDealer => role == EnumUserRole.dealer;
  // bool get isUser => role == EnumUserRole.user;
  String get createdAt => _createdAt;
  String get jwtToken =>
      //  kDebugMode
      //     ?
      // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTQ2NywibmFtZSI6IlNvbnUgS2hhbiIsImVtYWlsIjoiZGFzdGdpcmdkMUBnbWFpbC5jb20iLCJtb2JpbGUiOiI5NzExNjEwMjkzIiwiZXhwaXJlc0F0IjoiMjAyNi0wOC0xNVQwNjoxNjoyNS42MjJaIiwiaWF0IjoxNzg0MTgyNTg1LCJleHAiOjE3ODY3NzQ1ODV9.TdnMlE8H4dHqbwSopL62COt286-NHEyH5fROnLmXMV4"
      // :
      _jwtToken;
  String? get profileImage => null;
}
