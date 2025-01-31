import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_ceiba/presentation/common/app_bar.dart';
import 'package:prueba_ceiba/presentation/widgets/users/user_list.dart';
import 'package:prueba_ceiba/presentation/state_manager/user_bloc/user_bloc.dart';
import 'package:prueba_ceiba/presentation/state_manager/user_bloc/user_event.dart';
import 'package:prueba_ceiba/presentation/state_manager/user_bloc/user_state.dart';

class Userpage extends StatelessWidget {
  const Userpage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersBloc, UsersState>(
      listener: (context, state) {
        if (state is UsersInitial) {
          context.read<UsersBloc>().add(LoadUsers());
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBarWidget(
            'lista de usuarios',
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar usuario',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      if (state is ListUsersData) {
                       
                        if (value.isEmpty) {
                        context.read<UsersBloc>().add(ResetList());
                      } else {
                        context.read<UsersBloc>().add(FilterUsers(filter: value, listUsers: state.list));
                      }
                      }
                      
                    },
                  ),
                ),
                Expanded(
                  child: state is UsersLoadingState
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                              Text('Espere por favor..., mientras se cargan los usuarios'),
                            ],
                          ),
                        )
                      : state is ListUsersData
                          ? state.list.isEmpty
                              ? Center(
                                  child: Text('La lista es vacía'),
                                )
                              : UserList(users: state.list)
                          : Container(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
