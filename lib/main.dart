import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_diplom/message.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diploma',
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
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Diploma'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Message> _messages = [];

  Future<String> _getPath() {
    return FilePicker.platform.getDirectoryPath();
  }

  void _getJson() async {
    String filePath = await _getPath();
    if (filePath != null) {
      File file = File(filePath);
      String data = await file.readAsString();
      final result = json.decode(data);
      setState(() {
        _messages = getMessagesFromJson(result);
      });
    } else {
      String data = await rootBundle.loadString("assets/reg.json");
      final result = json.decode(data);
      setState(() {
        _messages = getMessagesFromJson(result);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _getTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Количество сообщений = ${_messages.length}'),
        if (_messages.length > 0) Text('Количество кадров в первом сообщении = ${_messages[0].frames.length}'),
      ],
    );
  }

  Widget _buildFrame(BuildContext context, int index) {
    return Container(
      child: Card(
        child: Column(
          children: [
            Text('id = ${_messages[0].frames[index].id}'),
            Text('name = ${_messages[0].frames[index].name}'),
            Text('isReg = ${_messages[0].frames[index].isReg}'),
            Text('maxCountReg = ${_messages[0].frames[index].maxCountReg}'),
            Text('countBufReg = ${_messages[0].frames[index].countBufReg}'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _getTitle(),
          _messages.length > 0
              ? Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
                    itemBuilder: _buildFrame,
                    itemCount: _messages[0].frames.length,
                  ),
                )
              : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getJson,
      ),
    );
  }
}
