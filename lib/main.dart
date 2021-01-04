import 'package:flutter/material.dart';

import 'history.dart';

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
        primaryColor: Color.fromARGB(255, 202, 194, 186),
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

  final TextStyle tabBarStyle = TextStyle(
      fontFamily: "AppleSDGothicNeo",
      fontWeight: FontWeight.w400,
      fontSize: 24,
      color: Color.fromARGB(255, 202, 194, 186)
  );

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;

    return DefaultTabController(length: 3,
      child:Scaffold(
        body: Center(
          child: TabBarView(
            children: [
              Container(
                width: _width,
                height: _height,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 35, 37, 43),
                ),
              ),
              Container(
                width: _width,
                height: _height,
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                ),
              ),
              History(),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(255, 35, 37, 43),
          child: Container(
            height: _height*0.08,
            child: TabBar(
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
