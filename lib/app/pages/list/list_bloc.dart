import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_hasura/app/app_module.dart';
import 'package:todo_hasura/app/app_repository.dart';
import 'package:todo_hasura/app/models/item_model.dart';
import 'package:todo_hasura/app/pages/home/home_bloc.dart';
import 'package:todo_hasura/app/pages/home/home_module.dart';

class ListBloc extends BlocBase {
  //dispose will be called automatically by closing its streams
  AppRepository repository = AppModule.to.get<AppRepository>();
  final homeBloc = HomeModule.to.getBloc<HomeBloc>();
  BehaviorSubject<List<ItemModel>> itemController = BehaviorSubject<List<ItemModel>>();
  Stream<List<ItemModel>> get outItems => itemController.stream;

  BehaviorSubject<ItemModel> singleItemController = BehaviorSubject<ItemModel>();
  Sink<ItemModel> get inSingleItem => singleItemController.sink;

  void getItems() async {
    itemController.sink.addStream(repository.getItems(homeBloc.singleListController.value.id));
  }

  void setComplete(bool value) {
    repository.setCompleted(singleItemController.value.id, singleItemController.value.completed);
  }

  @override
  void dispose() async {
    await itemController.drain();
    itemController.close();
    singleItemController.close();
    super.dispose();
  }
}
