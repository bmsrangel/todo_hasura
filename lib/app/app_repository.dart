import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:todo_hasura/app/models/item_model.dart';
import 'package:todo_hasura/app/models/list_model.dart';

class AppRepository extends Disposable {
  final HasuraConnect connection;

  AppRepository(this.connection);

  Stream<List<ListModel>> getLists() {
    var query = """
      subscription {
        lists {
          id
          name
        }
      }
    """;

    Snapshot snapshot = connection.subscription(query);
    return snapshot.stream.map((jsonList) => ListModel.fromJsonList(jsonList["data"]["lists"]));
  }

  Stream<List<ItemModel>> getItems(int id) {
    var query = """
      subscription(\$id:Int!) {
        items(where: {id_list: {_eq: \$id}}) {
          id
          description
          completed
        }
      }
    """;
    Snapshot snapshot = connection.subscription(query, variables: {"id": id});
    return snapshot.stream.map((jsonList) => ItemModel.fromJsonList(jsonList["data"]["items"]));
  }

  void setCompleted(int id, bool value) async {
    var query = """
      setCompleted(\$id:Int!, \$value:Boolean!) {
        update_items(where: {id: {_eq: \$id}}, _set: {completed: \$value}) {
          affected_rows
        }
      }
    """;
    var data = await connection.mutation(query, variables: {"id": id, "value": value});
    print(data["data"]["update_items"]["affected_rows"]);
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
