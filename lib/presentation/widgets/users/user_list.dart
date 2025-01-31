import 'package:flutter/material.dart';
import 'package:prueba_ceiba/domain/entities/user.dart';
import 'package:prueba_ceiba/presentation/widgets/users/user_card.dart';

class UserList extends StatelessWidget {
  final List<User> users;

  const UserList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserCard(userInfo: users[index]);
      },
    );
  }
}