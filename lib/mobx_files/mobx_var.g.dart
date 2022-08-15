// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_var.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Names on _Names, Store {
  late final _$namesAtom = Atom(name: '_Names.names', context: context);

  @override
  List<Map<String, String>> get names {
    _$namesAtom.reportRead();
    return super.names;
  }

  @override
  set names(List<Map<String, String>> value) {
    _$namesAtom.reportWrite(value, super.names, () {
      super.names = value;
    });
  }

  late final _$personAtom = Atom(name: '_Names.person', context: context);

  @override
  Person get person {
    _$personAtom.reportRead();
    return super.person;
  }

  @override
  set person(Person value) {
    _$personAtom.reportWrite(value, super.person, () {
      super.person = value;
    });
  }

  late final _$searchNameAsyncAction =
      AsyncAction('_Names.searchName', context: context);

  @override
  Future<Names> searchName(Names character) {
    return _$searchNameAsyncAction.run(() => super.searchName(character));
  }

  late final _$_NamesActionController =
      ActionController(name: '_Names', context: context);

  @override
  void getSearchedNames(List<Map<String, String>> response) {
    final _$actionInfo =
        _$_NamesActionController.startAction(name: '_Names.getSearchedNames');
    try {
      return super.getSearchedNames(response);
    } finally {
      _$_NamesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPersonDetail(Map<String, String> response) {
    final _$actionInfo =
        _$_NamesActionController.startAction(name: '_Names.setPersonDetail');
    try {
      return super.setPersonDetail(response);
    } finally {
      _$_NamesActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
names: ${names},
person: ${person}
    ''';
  }
}
