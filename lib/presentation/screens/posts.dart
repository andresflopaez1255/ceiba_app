import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_ceiba/domain/entities/user.dart';
import 'package:prueba_ceiba/presentation/common/app_bar.dart';
import 'package:prueba_ceiba/presentation/common/user_info.dart';
import 'package:prueba_ceiba/presentation/widgets/posts/post_list.dart';
import 'package:prueba_ceiba/presentation/state_manager/post_bloc/post_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late User user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = ModalRoute.of(context)!.settings.arguments as User;
    context.read<PostBloc>().add(FetchPostEvent(id: user.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBarWidget(
        'Posts de ${user.name}',
      ),
      body: Column(
        children: [
          UserInfo(userInfo: user),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Posts de ${user.name}', style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]
            ),),
          ),
          BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is PostErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')),
                );
              }
            },
            builder: (context, state) {
              if (state is PostLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ListPostsData) {
                return PostList(posts: state.list);
              } else if (state is PostErrorState) {
                return Center(
                  child: Text('Error: ${state.message}'),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}