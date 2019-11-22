import 'package:todo_hasura/app/pages/list/list_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:todo_hasura/app/pages/list/list_page.dart';

class ListModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => ListBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ListPage();

  static Inject get to => Inject<ListModule>.of();
}
