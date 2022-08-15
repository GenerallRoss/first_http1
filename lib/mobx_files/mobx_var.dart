import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import '../classes/person.dart';
import '../classes/person_info.dart';

part 'mobx_var.g.dart';

class Names = _Names with _$Names;

abstract class _Names with Store {
  final TextEditingController findController = TextEditingController();
  PersonInfo info = PersonInfo.empty();

  @observable
  List<String> names = [];

  // Краткая информация о персонаже при показе случайного (обновляется автоматически)
  @observable
  Person person = Person(name: '', height: '', mass: '');

  late Response dataResponse;

  @action
  void getSearchedNames(Response response) {
    names = response.data['results']
        .map<String>((item) => item['name'].toString())
        .toList();
  }

  @action
  void setPersonDetail(Response response) {
    person = Person(
        name: response.data['name'],
        height: response.data['height'],
        mass: response.data['mass']);
  }

  @action
  Future<Names> searchName(Names character) async {
    var dio = Dio();
    try {
      final response = await dio
          .get('https://swapi.dev/api/people/?search=${findController.text}');
      if (response.statusCode == 200) {
        character.dataResponse = response;
        character.getSearchedNames(response);
      }
      return character;
    } catch (e) {
      debugPrint(e.toString());
      return character;
    }
  }

  void getPersonDetails(Names character) async {
    var dio = Dio();
    var rng = Random(); // Рандомный id
    int i = rng.nextInt(10) + 1;
    late final Response response;
    try {
      response = await dio.get('https://swapi.dev/api/people/$i');
      if (response.statusCode == 200) {
        character.setPersonDetail(response);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getAllNames(Names character) async {
    var dio = Dio();
    try {
      final response = await dio.get('https://swapi.dev/api/people/');
      if (response.statusCode == 200) {
        character.dataResponse = response;
        character.getSearchedNames(response);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  PersonInfo showPersonDetail(int index, Names character) {
    var response = character.dataResponse.data['results'][index];
    PersonInfo info = PersonInfo(
        response['name'].toString(),
        response['height'].toString(),
        response['mass'].toString(),
        response['birth_year'].toString(),
        response['gender'].toString(),
        response['hair_color'].toString());
    return info;
  }
}
