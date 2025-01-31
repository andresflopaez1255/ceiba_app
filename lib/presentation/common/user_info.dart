import 'package:flutter/material.dart';
import 'package:prueba_ceiba/domain/entities/user.dart';

class UserInfo extends StatelessWidget {
    final User userInfo;

  const UserInfo({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userInfo.name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green[800]),
          ),
          Row(
            children: [
              Icon(
                Icons.phone,
                color: Colors.green[700],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  userInfo.phone,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.email,
                color: Colors.green[700],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                 userInfo.email,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
