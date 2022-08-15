import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:mobx/mobx.dart';
import '../classes/person.dart';
import '../classes/person_info.dart';

part 'mobx_var.g.dart';

// ignore: library_private_types_in_public_api
class Names = _Names with _$Names;

abstract class _Names with Store {
  final TextEditingController findController = TextEditingController();
  PersonInfo info = PersonInfo.empty();

  @observable
  List<Map<String, String>> names = [];

  // Краткая информация о персонаже при показе случайного (обновляется автоматически)
  @observable
  Person person = Person(name: '', height: '', mass: '');

  @action
  void getSearchedNames(List<Map<String, String>> list) {
    names = list;
  }

  @action
  void setPersonDetail(Map<String, String> map) {
    person = Person(
        name: map['name'].toString(),
        height: map['height'].toString(),
        mass: map['mass'].toString());
  }

  List<Map<String, String>> convertList(List<dynamic> list) {
    List<Map<String, String>> result = [];
    for (int i = 0; i < list.length; i++) {
      result.add({});
      var element = list[i];
      for (int n = 0; n < list[i].length; n++) {
        String key = element.keys.toList()[n].toString();
        String value = element[key].toString();
        result[i][key] = value;
      }
    }
    return result;
  }

  @action
  Future<Names> searchName(Names character) async {
    try {
      var dio = Dio();
      final response = await dio
          .get('https://swapi.dev/api/people/?search=${findController.text}');
      if (response.statusCode == 200) {
        names = convertList(response.data['results']);
        getSearchedNames(names);
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
    try {
      var response = await dio.get('https://swapi.dev/api/people/$i');
      if (response.statusCode == 200) {
        var t = convertList([response.data]);
        setPersonDetail(t[0]);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getAllNames() async {
    var dio = Dio();
    try {
      final response = await dio.get('https://swapi.dev/api/people/');
      if (response.statusCode == 200) {
        names = convertList(response.data['results']);
        getSearchedNames(names);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  PersonInfo showPersonDetail(int index, Names character) {
    PersonInfo info = PersonInfo(
        names[index]['name'].toString(),
        names[index]['height'].toString(),
        names[index]['mass'].toString(),
        names[index]['birth_year'].toString(),
        names[index]['gender'].toString(),
        names[index]['hair_color'].toString());
    return info;
  }
}
