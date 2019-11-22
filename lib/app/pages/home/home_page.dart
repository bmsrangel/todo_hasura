import 'package:flutter/material.dart';
import 'package:todo_hasura/app/models/list_model.dart';
import 'package:todo_hasura/app/pages/home/home_bloc.dart';
import 'package:todo_hasura/app/pages/home/home_module.dart';
import 'package:todo_hasura/app/pages/list/list_module.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Listas de Tarefas"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = HomeModule.to.getBloc<HomeBloc>();

  @override
  void initState() {
    super.initState();
    bloc.getLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: StreamBuilder<List<ListModel>>(
          stream: bloc.outList,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return ListView.separated(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    snapshot.data[index].name,
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    bloc.singleListController.value = null;
                    bloc.inSingleList.add(snapshot.data[index]);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ListModule()));
                  },
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {},
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            );
          }),
    );
  }
}
