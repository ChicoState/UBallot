import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
/*
https://flutter.io/docs/catalog/samples/expansion-tile-sample
https://stackoverflow.com/questions/49869873/flutter-update-widgets-on-resume
 */

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body:
          Center(
          child: ListView.builder(
            itemBuilder: (BuildContext context,int index)=>
                EntryItem(data[index]),
            itemCount: data.length,
          ),
        ),
      ),
    );
  }
}

class Entry {
  Entry(this.title, [this.children=const <Entry>[]]);

  final String title;
  final List<Entry> children;

}

final List<Entry> data = <Entry>[
  Entry(
    'first',
    <Entry>[
      Entry('tester'),
    ],
  ),
  Entry(
    'second',
    <Entry>[
      Entry('please work'),
    ],
  ),
];

class EntryItem extends StatelessWidget{
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if(root.children.isEmpty) {
      return ListTile(title: Text(root.title));
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildTiles(entry);
  }
}


handleAppLifecycleState() {
  AppLifecycleState _lastLifecyleState;
  SystemChannels.lifecycle.setMessageHandler((msg) {

    print('SystemChannels> $msg');

    switch (msg) {
      case "AppLifecycleState.paused":
        _lastLifecyleState = AppLifecycleState.paused;
        break;
      case "AppLifecycleState.inactive":
        _lastLifecyleState = AppLifecycleState.inactive;
        break;
      case "AppLifecycleState.resumed":
        _lastLifecyleState = AppLifecycleState.resumed;
        break;
      case "AppLifecycleState.suspending":
        _lastLifecyleState = AppLifecycleState.suspending;
        break;
      default:
    }
  });
}