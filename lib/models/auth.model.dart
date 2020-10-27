part of '../app.dart';

class AuthModel extends Equatable {
  final String fullname;
  final String username;

  AuthModel(this.username, {this.fullname});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(json['username'], fullname: json['fullname']);
  }
  Map<String, dynamic> toJson(Map<String, dynamic> json) {
    return {"username": json['username'], "fullname": json['fullname']};
  }

  AuthModel copyWith(String fullname) =>
      AuthModel(this.username, fullname: fullname ?? "");

  @override
  List<Object> get props => [username, fullname];
}
