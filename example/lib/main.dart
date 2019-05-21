import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/services.dart';
import 'package:z_components/z-alert-dialog.dart';
import 'package:z_components/z-float-button.dart';
import 'package:z_components/z_switch.dart';
import 'package:z_components/z_picker.dart';
import 'package:z_components/z_tabbar.dart';
import 'package:z_components/z_button.dart';

import 'package:z_components/z_navigationbar.dart';
import 'package:z_components/z_text_field.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool value = false;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Home(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, // if it's a RTL language
      ],
      supportedLocales: [
        const Locale('pt', 'BR'), // include country code too
      ],
    );
  }
}

class Home extends StatelessWidget {
  bool value = false;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ZFloatButton(
        onPressed: () {},
      ),
      appBar: new ZNavigationBar(
        title: new Text("teste"),
        centerTitle: true,
      ),
      body: new ListView(

        children: <Widget>[

          new Column(
              children: <Widget>[
                ZTextField(),

                ZSwitch(value: value, onChanged: (b) {}),
                ZButton(
                    child: Text('Show dialog!',style: new TextStyle(color: Colors.white),),
                    onPressed: () {
                      new ZPicker(
                        context: context,
                        onTimerDurationChanged: (date) {
                          date;
                        },
                      );
                    }),
                ZButton(child: Text("dialog"),onPressed: (){
                 showDialog(  context: context,
                     builder: (BuildContext context) => ZAlertDialog(title: Text("teste"),actions: <Widget>[FlatButton(child: new Icon(Icons.add),)],));
                },)



              ]),
        ],
      ),
      bottomNavigationBar: ZtabBar(
        backgroundColor: Colors.teal,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        onTap: (index) => this.index = index,
        currentIndex: 0,
        iconSize: 16,
        inactiveColor: Colors.red,
        activeColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black45,
        // currentIndex: _selectedIndex,
      ),
    );
  }
}
