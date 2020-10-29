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
