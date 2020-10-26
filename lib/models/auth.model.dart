part of '../app.dart';

class AuthModel extends Equatable {

    AuthModel();

    factory AuthModel.fromJson(Map<String, dynamic> json) {
        return AuthModel();
    }
    Map<String, dynamic> toJson() {
        return {};
    }

    AuthModel copyWith() => AuthModel();

    @override
    List<Object> get props => [];
}
