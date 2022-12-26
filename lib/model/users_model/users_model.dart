class UsersModel {
  String? firstName;
  String? lastName;
  String? email;
  String? wrole;
  String? uid;
  String? tuid;
  String? image;
  int? mobile;
  String? birthDate;

  UsersModel({this.firstName, this.lastName, this.email, this.uid, this.wrole, this.image, this.mobile, this.birthDate, this.tuid});

  UsersModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first name'];
    lastName = json['last name'];
    email = json['email'];
    wrole = json['role'];
    uid = json['uid'];
    image = json['image'];
    mobile = json['mobile'];
    birthDate = json['birth date'];
    tuid = json['tuid'];
  }
}