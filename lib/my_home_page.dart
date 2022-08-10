import 'package:first_http1/person.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Person person = Person(name: '', height: '', mass: '');

  final TextEditingController _findController = TextEditingController();
  List<String> names = [];

  void getPersonDetails() async {
    var dio = Dio();
    var rng = Random(); // Рандомный id
    int i = rng.nextInt(10) + 1;
    late final Response response;
    try {
      response = await dio.get('https://swapi.dev/api/people/$i');
      setState(() {
        person = Person(
            name: response.data['name'],
            height: response.data['height'],
            mass: response.data['mass']);
      });
    } catch (e) {}
  }

  void getAllNames() async {
    var dio = Dio();
    final response = await dio.get('https://swapi.dev/api/people/');
    var index = response.data['results'];
    setState(() {
      for (int i = 0; i < index.length; i++) {
        names.add(response.data['results'][i]['name']);
      }
    });
  }

  void searchName() async {
    var dio = Dio();
    final response = await dio
        .get('https://swapi.dev/api/people/?search=${_findController.text}');
    var index = response.data['results'];
    setState(() {
      names.clear();
      for (int i = 0; i < index.length; i++) {
        names.add(response.data['results'][i]['name']);
      }
      names = response.data['results']
          .map<String>((item) => item['name'].toString())
          .toList();
    });
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
                onPressed: () {
                  getPersonDetails();
                },
                child: const Text(
                  'Показать случайного персонажа',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text('Имя: ${person.name}'),
            const SizedBox(
              height: 10,
            ),
            Text('Рост: ${person.height}'),
            const SizedBox(
              height: 10,
            ),
            Text('Масса: ${person.mass}'),
            const SizedBox(
              height: 30,
            ),
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
            ListView.builder(
                itemCount: names.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // return Padding(
                  //   padding: EdgeInsets.only(bottom: 10),
                  //   child: (Text(names[index])),
                  // );
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: (Text(names[index])),
                      )
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
