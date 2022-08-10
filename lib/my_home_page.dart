import 'package:first_http1/person.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'dart:math';
import 'package:mobx/mobx.dart';

import 'mobx_var.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _findController = TextEditingController();
  final Names nms = Names();

  void getPersonDetails() async {
    var dio = Dio();
    var rng = Random(); // Рандомный id
    int i = rng.nextInt(10) + 1;
    late final Response response;
    try {
      response = await dio.get('https://swapi.dev/api/people/$i');
      if (response.statusCode == 200) {
        // setState(() {
        //   person = Person(
        //       name: response.data['name'],
        //       height: response.data['height'],
        //       mass: response.data['mass']);
        // });
        nms.setPersonalDetail(response);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getAllNames() async {
    var dio = Dio();
    try {
      final response = await dio.get('https://swapi.dev/api/people/');
      nms.getSearchedNames(response);
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
      nms.getSearchedNames(response);
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
                  Text('Имя: ${nms.person.name}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Рост: ${nms.person.height}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Масса: ${nms.person.mass}'),
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
                  itemCount: nms.names.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: (Text(
                        nms.names[index],
                        textAlign: TextAlign.center,
                      )),
                    );
                  });
            })
          ],
        ),
      ),
    );
  }
}
