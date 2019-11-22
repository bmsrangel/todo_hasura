import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:todo_hasura/app/pages/list/list_bloc.dart';
import 'package:todo_hasura/app/pages/list/list_module.dart';

void main() {
  initModule(ListModule());
  ListBloc bloc;

  setUp(() {
    bloc = ListModule.to.bloc<ListBloc>();
  });

  group('ListBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<ListBloc>());
    });
  });
}
