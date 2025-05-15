class UserModel {
  String? token;
  String? userEmail;
  String? userNickname;
  String? userDisplayName;

  UserModel({this.token, this.userEmail, this.userNickname, this.userDisplayName});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userEmail = json['user_email'];
    userNickname = json['user_nickname'];
    userDisplayName = json['user_display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['user_email'] = userEmail;
    data['user_nickname'] = userNickname;
    data['user_display_name'] = userDisplayName;
    return data;
  }
}

class CurrentUserModel {
  String? id;
  String? description;

  CurrentUserModel({this.id, this.description});

  CurrentUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    return data;
  }
}