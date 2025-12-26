import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({ required this.id, required this.name, required this.nickName, required this.deptId, required this.deptName, required this.permissions, required this.roles });

  final int id;
  final String name;
  final String nickName;
  final int deptId;
  final String deptName;
  final List<String> permissions;
  final List<String> roles;

  @override
  List<Object> get props => [id, name, nickName, deptId, deptName, permissions, roles];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['userId'],
      name: json['user']['userName'],
      nickName: json['user']['nickName'],
      deptId: json['user']['deptId'],
      deptName: json['user']['deptName'],
      permissions: json['permissions'].cast<String>(),
      roles: json['roles'].cast<String>(),
    );
  }
}