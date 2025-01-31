

import 'package:prueba_ceiba/domain/entities/user.dart';

abstract class UsersState {}

class UsersInitial extends UsersState {}

class ListUsersData extends UsersState {
  final List<User> list;
  ListUsersData(this.list);
}

class UsersLoadingState extends UsersState {}