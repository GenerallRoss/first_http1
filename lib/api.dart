import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<Response?> APIsearch(TextEditingController findController) async {
  var dio = Dio();
  final response = await dio
      .get('https://swapi.dev/api/people/?search=${findController.text}');
  return response;
}

Future<Response?> APIgetPersonalDetails() async {
  var dio = Dio();
  var rng = Random(); // Рандомный id
  int i = rng.nextInt(10) + 1;
  var response = await dio.get('https://swapi.dev/api/people/$i');
  return response;
}

Future<Response?> APIgetAllNames() async {
  var dio = Dio();
  return await dio.get('https://swapi.dev/api/people/');
}
