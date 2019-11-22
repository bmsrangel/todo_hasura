import 'package:flutter/material.dart';
import 'package:todo_hasura/app/models/item_model.dart';
import 'package:todo_hasura/app/pages/list/list_bloc.dart';
import 'package:todo_hasura/app/pages/list/list_module.dart';

class ListPage extends StatefulWidget {
  final String title;
  const ListPage({Key key, this.title = "List"}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final bloc = ListModule.to.getBloc<ListBloc>();
  @override
  void initState() {
    super.initState();
    bloc.getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<ItemModel>>(
          stream: bloc.outItems,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  title: Text(snapshot.data[index].description),
                  value: snapshot.data[index].completed,
                  onChanged: (bool value) {
                    final ItemModel item = snapshot.data[index];
                    item.completed = value;
                    bloc.inSingleItem.add(item);
                    bloc.setComplete(value);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
