import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/alarm_model.dart';

import 'alarm_helper.dart';

import 'views/alarm.dart';
import 'views/setting.dart';
import 'views/history.dart';

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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  var _alarm;
  DateTime _time = DateTime.now();
  AlarmHelper _alarmHelper = AlarmHelper();
  String _targetTime;

  final TextStyle tabBarStyle = TextStyle(
      fontFamily: "AppleSDGothicNeo",
      fontWeight: FontWeight.w400,
      fontSize: 21,
      color: Color.fromARGB(255, 202, 194, 186)
  );

  @override
  void initState(){
   _alarmHelper.database.then((value){
     print("----------initialize database");
     loadData();
   });
   super.initState();
  }
  void loadData() {
    print("load alarm");
    _alarm = _alarmHelper.getAlarm(0);
    print("finish alarm");
    print("_alarm: ${_alarm}");
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;

    return FutureBuilder(
      future: _alarm,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return DefaultTabController(length: 3,
            child:Scaffold(
              body: Center(
                child: TabBarView(
                  children: [
                    AlarmTab(alarm: _time,),
                    SettingTab(),
                    HistoryTab(),
                  ],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                color: Color.fromARGB(255, 35, 37, 43),
                child: Container(
                  height: _height*0.08,
                  child: TabBar(
                    indicatorColor: Color.fromARGB(255, 156, 143, 128),
                    tabs: [
                      _tab("Alarm"),
                      _tab("Setting"),
                      _tab("History"),
                    ],
                  ),
                ),
              ),
            ),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Tab _tab(String title){
    return Tab(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: "AppleSDGothicNeo",
            fontWeight: FontWeight.w400,
            fontSize: 24,
            color: Color.fromARGB(255, 202, 194, 186)
        ),
      ),
    );
  }
}
