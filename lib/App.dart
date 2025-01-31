import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prueba_ceiba/data/source_data/network_source.dart';
import 'package:prueba_ceiba/domain/entities/user.dart';
import 'package:prueba_ceiba/domain/repositories/local_repositories/local_user_repository.dart';
import 'package:prueba_ceiba/domain/repositories/network_repositories.dart/post_repository.dart';
import 'package:prueba_ceiba/domain/repositories/network_repositories.dart/user_repository.dart';
import 'package:prueba_ceiba/domain/useCases/load_users.dart';
import 'package:prueba_ceiba/presentation/screens/posts.dart';
import 'package:prueba_ceiba/presentation/screens/users.dart';
import 'package:prueba_ceiba/presentation/state_manager/post_bloc/post_bloc.dart';
import 'package:prueba_ceiba/presentation/state_manager/user_bloc/user_bloc.dart';
import 'package:prueba_ceiba/presentation/state_manager/user_bloc/user_event.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NetWorkUserRepository>(
          create: (context) => NetWorkUserRepository(
            networkSource: NetworkSource(),
          ),
        ),
        RepositoryProvider<LocalUserRepository>(
          create: (context) => LocalUserRepository(
            userBox: Hive.box<User>('users'),
          ),
        ),
        RepositoryProvider<LoadUsersUseCaseRepository>(
          create: (context) => LoadUsersUseCaseRepository(
            localUserRepository: context.read(),
            networkUserRepository: NetWorkUserRepository(
              networkSource: NetworkSource(),
            ),
          ),
        ),
         RepositoryProvider<PostRepository>(
          create: (context) => PostRepository(
            networkSource: NetworkSource(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UsersBloc>(
            create: (context) => UsersBloc(
              repository: context.read<LoadUsersUseCaseRepository>(),
            )..add(LoadUsers()),
          ),
           BlocProvider<PostBloc>(
            create: (context) => PostBloc(
              postRepository: context.read<PostRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
                    initialRoute: '/',
          routes: {
            '/': (context) => Userpage(),
            '/posts': (context) => PostsPage()
          },
        ),
      ),
    );
  }
}
