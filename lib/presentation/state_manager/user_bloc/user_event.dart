

import 'package:prueba_ceiba/domain/entities/user.dart';

abstract class UsersEvent  {
  const UsersEvent();

}

class LoadUsers extends UsersEvent {}

class FilterUsers extends UsersEvent {

  final String filter;

  final List<User> listUsers;



  FilterUsers({required this.filter, required this.listUsers});

}


class  ResetList extends UsersEvent {}