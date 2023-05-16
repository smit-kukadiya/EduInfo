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
  String? groupDefault;
  String? groupStudent;
  String? groupParent;
  String? accountNo;
  String? ifscCode;
  String? recipientName;

  UsersModel({this.firstName, this.lastName, this.email, this.uid, this.wrole, this.image, this.mobile, this.birthDate, this.tuid, this.groupDefault, this.groupStudent, this.groupParent, this.accountNo, this.ifscCode, this.recipientName});

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
    groupDefault = json['group default'];
    groupStudent = json['group student'];
    groupParent = json['group parent'];
    accountNo = json['account no'];
    ifscCode = json['ifsc code'];
    recipientName = json['recipient name'];
  }
}