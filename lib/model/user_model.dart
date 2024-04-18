class UserModel {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  bool? isRemember;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.password,
      this.isRemember});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    password = json['password'];
    isRemember = json['isRemember'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['password'] = password;
    data['isRemember'] = isRemember;
    return data;
  }
}
