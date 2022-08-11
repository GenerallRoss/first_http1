import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../mobx_files/mobx_var.dart';
import 'person_info.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _findController = TextEditingController();
  final Names character = Names();
  List<String> info = [];

  void showPersonDetail(int index) {
    var response = character.dataResponse.data['results'][index];
    info.clear();
    info.add(response['name'].toString());
    info.add(response['height'].toString());
    info.add(response['mass'].toString());
    info.add(response['birth_year'].toString());
    info.add(response['gender'].toString());
    info.add(response['hair_color'].toString());
  }

  void getPersonDetails() async {
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

  void getAllNames() async {
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

  @action
  void searchName() async {
    var dio = Dio();
    try {
      final response = await dio
          .get('https://swapi.dev/api/people/?search=${_findController.text}');
      if (response.statusCode == 200) {
        character.dataResponse = response;
        character.getSearchedNames(response);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    getAllNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueAccent,
              child: MaterialButton(
                onPressed: getPersonDetails,
                child: const Text(
                  'Показать случайного персонажа',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Observer(builder: (_) {
              return Column(
                children: [
                  Text('Имя: ${character.person.name}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Рост: ${character.person.height}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Масса: ${character.person.mass}'),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              );
            }),
            const Text(
              'Список персонажей:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                  width: 200,
                  child: TextFormField(
                    autofocus: false,
                    controller: _findController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                    onPressed: searchName, icon: const Icon(Icons.search))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Observer(builder: (_) {
              return ListView.builder(
                  itemCount: character.names.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextButton(
                        onPressed: () {
                          showPersonDetail(index);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PersonInfo(info: info)));
                        },
                        child: Text(
                          character.names[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 46, 46, 46)),
                        ),
                      ),
                    );
                  });
            })
          ],
        ),
      ),
    );
  }
}
