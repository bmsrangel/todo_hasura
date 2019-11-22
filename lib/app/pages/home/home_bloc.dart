import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_hasura/app/app_repository.dart';
import 'package:todo_hasura/app/models/list_model.dart';

class HomeBloc extends BlocBase {
  //dispose will be called automatically by closing its streams
  BehaviorSubject<List<ListModel>> listController = BehaviorSubject<List<ListModel>>();
  Stream<List<ListModel>> get outList => listController.stream;

  BehaviorSubject<ListModel> singleListController = BehaviorSubject<ListModel>();
  Sink<ListModel> get inSingleList => singleListController.sink;
  final AppRepository repository;

  HomeBloc(this.repository);

  void getLists() async {
    listController.sink.addStream(repository.getLists());
  }

  @override
  void dispose() {
    listController.close();
    singleListController.close();
    super.dispose();
  }
}
