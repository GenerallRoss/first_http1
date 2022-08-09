import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String personName = '';
  String personHeight = '';
  String personMass = '';

  final TextEditingController _findController = TextEditingController();
  final List<String> names = [];

  void callHTTP() async {
    var dio = Dio();
    var rng = Random(); // Рандомный id
    int i = rng.nextInt(10) + 1;
    final response = await dio.get('https://swapi.dev/api/people/$i');
    setState(() {
      personName = response.data['name'];
      personHeight = response.data['height'];
      personMass = response.data['mass'];
    });
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
    });
    print(response.data);
  }

  @override
  void initState() {
    getAllNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent,
                child: MaterialButton(
                  onPressed: () {
                    callHTTP();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Имя: $personName')],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Рост: $personHeight')],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Масса: $personMass')],
              ),
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
                      onPressed: () {
                        searchName();
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: names.length * 75,
                child: ListView.builder(
                    itemCount: names.length,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(names[index]),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
