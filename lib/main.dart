import 'package:flut_uno/database.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Sqlite'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TaskDatabase db = TaskDatabase();
  List<String> _tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        //usar un futurebuilder e inicializar la db
        body: FutureBuilder(
          future: db.initDB(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  for (String task in _tasks) ListTile(title: Text(task))
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addTask,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }

  //funcion para agregar
  _addTask() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              TextField(
                decoration:
                    InputDecoration(icon: Icon(Icons.add_circle_outline)),
                onSubmitted: (text) {
                  setState(() {
                    _tasks.add(text);
                    Navigator.pop(context);
                  });
                },
              )
            ],
          );
        });
  }
}
