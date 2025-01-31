import 'package:flutter/material.dart';
import 'package:prueba_ceiba/domain/entities/user.dart';
import 'package:prueba_ceiba/presentation/common/user_info.dart';


class UserCard extends StatelessWidget {
    final User userInfo;

  const UserCard({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Card(
      color:  Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              UserInfo( userInfo: userInfo),
              ],
            ),
        
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/posts', arguments: userInfo);
                    },
                    child: Text(
                      "Ver publicaciones",
                      style: TextStyle(
                        color: Colors.green[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                 
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
