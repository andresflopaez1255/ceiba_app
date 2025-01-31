import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prueba_ceiba/App.dart';
import 'package:prueba_ceiba/data/source_data/network_source.dart';
import 'package:prueba_ceiba/domain/entities/user.dart';
import 'package:prueba_ceiba/domain/repositories/network_repositories.dart/post_repository.dart';
import 'package:prueba_ceiba/presentation/state_manager/post_bloc/post_bloc.dart';
import 'package:prueba_ceiba/presentation/state_manager/user_bloc/user_bloc.dart';
import 'package:prueba_ceiba/domain/repositories/local_repositories/local_user_repository.dart';
import 'package:prueba_ceiba/domain/repositories/network_repositories.dart/user_repository.dart';
import 'package:prueba_ceiba/domain/useCases/load_users.dart';
import 'package:prueba_ceiba/presentation/state_manager/user_bloc/user_event.dart';

import 'data/source_data/local_source.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(GeoAdapter());
  Hive.registerAdapter(CompanyAdapter());
  await Hive.openBox<User>('users');
  LocalSource().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              postRepository: PostRepository(
                networkSource: NetworkSource(),
              ),
            ),
          ),
        ],
        child: App(),
      ),
    );
  }
}

