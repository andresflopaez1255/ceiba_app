import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_ceiba/domain/entities/user.dart';
import 'package:prueba_ceiba/domain/useCases/load_users.dart';
import 'package:prueba_ceiba/presentation/state_manager/user_bloc/user_event.dart';
import 'package:prueba_ceiba/presentation/state_manager/user_bloc/user_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final LoadUsersUseCaseRepository repository;

  UsersBloc({required this.repository}) : super(UsersInitial()) {
    on<LoadUsers>(getUsers);
    on<FilterUsers>(_filterUsers);
    on<ResetList>(_resetList );
  }

  getUsers(LoadUsers event, Emitter<UsersState> emit) async {
    emit(UsersLoadingState());
    final listResponse =  await repository.getUsers();
   
    emit(ListUsersData(listResponse ));
  }

  void _filterUsers(FilterUsers event, Emitter<UsersState> emit) {
    final filter = event.filter;
    final listUsers = event.listUsers;

    if (filter.isEmpty) {
      emit(ListUsersData(listUsers));
      return;
    }

    List<User> listFilter = listUsers.where((user) {
      return user.name.toLowerCase().contains(filter.toLowerCase());
    }).toList();

    emit(ListUsersData(listFilter));
  }

   void _resetList(ResetList event, Emitter<UsersState> emit) {
     getUsers(LoadUsers(), emit);
    

   }
}