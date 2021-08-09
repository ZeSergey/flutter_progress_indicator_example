import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Progress Indicator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _counterProgress = 0;
  bool _progressDone = false;

  void startPogress() {
    Timer.periodic(Duration(milliseconds: 300), (Timer t) {
      setState(() {
        if (_counterProgress.toStringAsFixed(1) == '1.0') {
          t.cancel();
          _progressDone = true;
          return;
        }
        _counterProgress += 0.1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text('Flutter Progress Indicator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LinearProgressIndicator(
                backgroundColor: Colors.white,
                value: _counterProgress,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  '${(_counterProgress * 100).round()} %',
                ),
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: startPogress,
                  child: Text(
                    _progressDone ? 'Done' : 'Start',
                    style: TextStyle(color: Colors.white),
                  )),
              AnimatedOpacity(
                opacity: _progressDone ? 1 : 0,
                duration: const Duration(seconds: 1),
                child: Icon(
                  Icons.done,
                  color: Colors.green,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _progressDone ? 1 : 0,
        duration: const Duration(seconds: 1),
        child: _progressDone
            ? FloatingActionButton(
                child: Icon(Icons.restart_alt),
                onPressed: () => setState(() {
                  _counterProgress = 0;
                  _progressDone = false;
                }),
              )
            : null,
      ),
    );
  }
}
