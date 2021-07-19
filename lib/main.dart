import 'package:flut_uno/database.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
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
