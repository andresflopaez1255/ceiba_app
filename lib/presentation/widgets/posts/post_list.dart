import 'package:flutter/material.dart';
import 'package:prueba_ceiba/domain/entities/post.dart';

class PostList extends StatelessWidget {
  final List<Post> posts;

  const PostList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return  PostCard(post: posts[index]);
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({
    super.key, required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color:  Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${post.title}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),

            Text(
              ' ${post.body}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}