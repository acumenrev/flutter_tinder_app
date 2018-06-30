import 'package:flutter/material.dart';
import 'package:flutter_tinder_app/common/round_icon_button.dart';
import 'package:fluttery/layout.dart';
import 'common/profile_card.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
        primaryColorBrightness: Brightness.light

      ),
      home: new MyHomePage(title: ''),
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
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget _buildAppBar() {
    return new AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: new FlutterLogo(
        colors: Colors.red,
        size: 30.0,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: new IconButton(
          icon: new Icon(
            Icons.person,
            color: Colors.grey,
              size: 40.0,

          ),
          onPressed: () => {
            // TODO:
          }),
      actions: <Widget>[
        new IconButton(
            icon: new Icon(
              Icons.bubble_chart,
              color: Colors.grey,
              size: 40.0,

            ),
            onPressed: () => {
              // TODO:
            }),
      ],
    );
  }

  Widget _buildBottomBar() {
    return new BottomAppBar(
      elevation: 0.0,
      color: Colors.transparent,
      child: new Padding(
        padding: const EdgeInsets.all(15.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new RoundIconButton.small(
              iconColor: Colors.orange,
              icon: Icons.refresh,
              onPressed: () {

              },
            ),
            new RoundIconButton.large(
              icon: Icons.clear,
              iconColor: Colors.red,
              onPressed: () {

              },
            ),
            new RoundIconButton.small(
              iconColor: Colors.blue,
              icon: Icons.star,
              onPressed: () {

              },
            ),
            new RoundIconButton.large(
              icon: Icons.favorite,
              iconColor: Colors.red,
              onPressed: () {

              },
            ),
            new RoundIconButton.small(
              iconColor: Colors.blue,
              icon: Icons.lock,
              onPressed: () {

              },
            )
          ],
        )
      )
    );
  }

  Widget _buildCardStack() {
    return DragableCard();
  }


  @override
  Widget build(BuildContext context) {


    return new Scaffold(
      appBar: _buildAppBar(),
      body: new DragableCard(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }


}
