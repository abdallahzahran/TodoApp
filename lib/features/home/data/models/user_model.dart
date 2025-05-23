class LoginResponseModel {
  String? accessToken;
  String? refreshToken;
  bool? status;
  UserModel? user;

  LoginResponseModel(
      {this.accessToken, this.refreshToken, this.status, this.user});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    status = json['status'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json ={};
    json['access_token'] = accessToken;
    json['refresh_token'] = refreshToken;
    json['status'] = status;
    if (user != null) {
      json['user'] = user!.toJson();
    }
    return json;
  }
}

class UserModel {
  int? id;
  String? imagePath;
  String? username;

  UserModel({this.id, this.imagePath, this.username});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagePath = json['image_path'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_path'] = this.imagePath;
    data['username'] = this.username;
    return data;
  }
}