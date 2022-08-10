import 'package:flutter/material.dart';

class PersonInfo extends StatelessWidget {
  const PersonInfo({Key? key, required this.info}) : super(key: key);
  final List<String> info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Text('Имя: ${info[0]}'),
          const SizedBox(
            height: 10,
          ),
          Text('Рост (см): ${info[1]}'),
          const SizedBox(
            height: 10,
          ),
          Text('Вес (кг): ${info[2]}'),
          const SizedBox(
            height: 10,
          ),
          Text('Год рождения: ${info[3]}'),
          const SizedBox(
            height: 10,
          ),
          Text('Пол: ${info[4]}'),
          const SizedBox(
            height: 10,
          ),
          Text('Цвет волос: ${info[5]}'),
          const SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }
}
