class UsersModel {
  String? firstName;
  String? lastName;
  String? email;
  String? wrole;
  String? uid;

  UsersModel({this.firstName, this.lastName, this.email, this.uid, this.wrole});

  UsersModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first name'];
    lastName = json['last name'];
    email = json['email'];
    wrole = json['role'];
    uid = json['uid'];
  }
}