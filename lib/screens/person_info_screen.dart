import 'package:first_http1/classes/person_info.dart';
import 'package:flutter/material.dart';

class PersonInfoScreen extends StatelessWidget {
  const PersonInfoScreen({Key? key, required this.info}) : super(key: key);
  final PersonInfo info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Text('Имя: ${info.name}'),
          const SizedBox(
            height: 10,
          ),
          Text('Рост (см): ${info.height}'),
          const SizedBox(
            height: 10,
          ),
          Text('Вес (кг): ${info.mass}'),
          const SizedBox(
            height: 10,
          ),
          Text('Год рождения: ${info.birthYear}'),
          const SizedBox(
            height: 10,
          ),
          Text('Пол: ${info.gender}'),
          const SizedBox(
            height: 10,
          ),
          Text('Цвет волос: ${info.hairColor}'),
          const SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }
}
