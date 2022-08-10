import 'package:dio/dio.dart';
import 'package:first_http1/person.dart';
import 'package:mobx/mobx.dart';

part 'mobx_var.g.dart';

class Names = _Names with _$Names;

// @observable
// List<String> names = [];

// @action
// void a(Response response) {
//   names = response.data['results']
//       .map<String>((item) => item['name'].toString())
//       .toList();
// }

abstract class _Names with Store {
  @observable
  List<String> names = [];

  @observable
  Person person = Person(name: '', height: '', mass: '');

  @action
  void getSearchedNames(Response response) {
    names = response.data['results']
        .map<String>((item) => item['name'].toString())
        .toList();
  }

  @action
  void setPersonalDetail(Response response) {
    person = Person(
        name: response.data['name'],
        height: response.data['height'],
        mass: response.data['mass']);
  }
}
