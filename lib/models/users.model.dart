part of '../app.dart';
class UsersModel extends Equatable {

    UsersModel();

    factory UsersModel.fromJson(Map<String, dynamic> json) {
        return UsersModel();
    }
    Map<String, dynamic> toJson() {
        return {};
    }

    UsersModel copyWith() => UsersModel();

    @override
    List<Object> get props => [];
}
