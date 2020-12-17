/*
module  : USER MODEL
creator : adhityarachmanh
os      : darwin19
created : Thu Dec 17 20:21:01 WIB 2020
product : ARH
version : v1.0
*/

part of '../app.dart';

class UserModel extends Equatable {

    UserModel();

    factory UserModel.fromJson(Map<String, dynamic> json) {
        return UserModel();
    }
    
    Map<String, dynamic> toJson() {
        return {};
    }

    UserModel copyWith() => UserModel();

    @override
    List<Object> get props => [];
}
