import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../mobx_files/mobx_var.dart';
import 'person_info_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Names character = Names();

  @override
  void initState() {
    character.getAllNames();
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
                  character.getPersonDetails(character);
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
                    controller: character.findController,
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
                      character.searchName(character);
                    },
                    icon: const Icon(Icons.search))
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
                          character.info =
                              character.showPersonDetail(index, character);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PersonInfoScreen(info: character.info)));
                        },
                        child: Text(
                          "${character.names[index]['name']}",
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
