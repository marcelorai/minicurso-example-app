import 'package:flutter/material.dart';
import 'package:minicurso/bloc/counter_bloc.dart';
import 'package:minicurso/mobx/counter_mobx.dart';
import 'package:minicurso/mobx_codegen/counter_mobx_codegen.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:minicurso/pages/todo_bloc_page.dart';
import 'package:minicurso/pages/todo_mobx_page.dart';

void main() => runApp(MyApp());

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        '/todo-bloc-page': (context) => TodoBlocPage(),
        '/todo-mobx-page': (context) => TodoMobxPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CounterBloc _counterBloc = CounterBloc();
  CounterMobx _counterMobx = CounterMobx();
  CounterMobxCodegen _counterMobxCodegen = CounterMobxCodegen();

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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),

            // Bloc
            // StreamBuilder(
            //   stream: _counterBloc.output,
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     }

            //     switch (snapshot.connectionState) {
            //       case ConnectionState.waiting:
            //         return CircularProgressIndicator();

            //       default:
            //         return Text(
            //           snapshot.data.toString(),
            //           style: TextStyle(fontSize: 34),
            //         );
            //     }
            //   },
            // ),

            // MobX
            Observer(
              builder: (BuildContext context) {
                return Text(
                  _counterMobxCodegen.counter.toString(),
                  style: TextStyle(fontSize: 34),
                );
              },
            ),
            RaisedButton(
              child: Text('Todo Bloc Page'),
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed('/todo-bloc-page');
              },
            ),
            RaisedButton(
              child: Text('Todo Mobx Page'),
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed('/todo-mobx-page');
              },
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            onPressed: _counterMobxCodegen.decrement,
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _counterMobxCodegen.increment,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
